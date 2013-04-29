require 'cocaine'
require 'shellwords'
require 'net/ssh'

module Server
  class Connection
    def initialize(host, user = 'octo', keys: [SSH_KEY_PATH])
      @host = 'v2.parallel.ru' # host
      @user = 'evrone' # user
      @keys = keys
    end
    
    def run(cmd)
      # cmd = Cocaine::CommandLine.new("ssh", "#{@user}@#{@host} -i #{SSH_KEY_PATH} -t #{cmd}")
      # cmd.run.chomp
      ::Net::SSH.start(@host, @user, keys: @keys) do |ssh|
        ssh.exec!(cmd).to_s.chomp
      end
    end
  end
  
  class Group
    attr_reader :host, :name, :request_state, :project_state
    
    def initialize(name, host, request_state, project_state)
      @name = name
      @host = 'v2.parallel.ru' # host
      @request_state = request_state
      @project_state = project_state
      @connection = Connection.new(host)
    end
    
    def synchronize
      case project_state
      when :active
        ensure_activing
      when :closed
        ensure_closing
      end
    end
    
    def ensure_activing
      active? || add_group
    end
    
    def ensure_closing
      active? && delete_group
    end
  
    private
    def add_group
      @connection.run("sudo /usr/octo/add_group #{name}")
    end
    
    def delete_group
      # nothing...
      true
    end
    
    def active?
      groups.include? name
    end
    
    def groups
      @groups ||= begin
        raw = @connection.run("cat /etc/group")
        raw.each_line.map do |line|
          line[/(\w+):/, 1]
        end
      end
    end
  end
  
  class User
    attr_reader :access_state, :cluster_state, :group, :name
    
    def initialize(name, group, access_state, cluster_state)
      @name  = name
      @group = group
      @access_state = access_state
      @cluster_state = cluster_state
      @connection = Connection.new(group.host)
    end
    
    def allowed?
      access_state == :allowed && cluster_state == :active
    end
    
    def synchronize
      if group.project_state == :active
        if allowed? && group.request_state == :active
          ensure_activing
        else
          ensure_blocking
        end
      else
        ensure_closing
      end
    end
    
    def ensure_activing
      active? || (blocked? ? unblock : add)
    end
    
    def ensure_closing
      (not closed?) && remove
    end
    
    def ensure_blocking
      blocked? || block
    end
    
    private
    def closed?
      check_user == 'closed'
    end
    
    def active?
      check_user == 'active'
    end
    
    def check_user
      @connection.run("sudo /usr/octo/check_user #{name} #{group.name}")
    end
    
    def blocked?
      check_user == 'blocked'
    end
    
    def add
      @connection.run("sudo /usr/octo/add_user #{name} #{group.name}")
    end
    
    def remove
      @connection.run("sudo /usr/octo/del_user #{name}")
    end
    
    def block
      @connection.run("sudo /usr/octo/block_user #{name}")
    end
    
    def unblock
      @connection.run("sudo /usr/octo/unblock_user #{name}")
    end
  end
  
  class Key
    attr_reader :user, :state
    
    def initialize(value, user, state)
      @value = value
      @user  = user
      @state = state
      @connection = Connection.new(user.group.host)
    end
    
    def synchronize
      case true
      when user.allowed? && state == :active && user.group.project_state == :active
        ensure_activing
      when :closed then
        ensure_closing
      end
    end
    
    def ensure_activing
      persisted? || add
    end
    
    def ensure_closing
      persisted? && remove
    end
    
    private
    def remove
      key_command do |path|
        @connection.run("sudo /usr/octo/del_openkey #{user.name} #{path}")
      end
    end
    
    def persisted?
      key_command do |path|
        @connection.run("sudo /usr/octo/check_openkey #{user.name} #{path}")
      end == 'found'
    end
    
    def add
      key_command do |path|
        @connection.run("sudo /usr/octo/add_openkey #{user.name} #{path}")
      end
    end
    
    def key_command
      key = @value.shellescape
      path = "/tmp/octo-#{SecureRandom.hex}"
      File.open(path, 'wb') { |f| f.write key }
      Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} #{path} evrone@#{user.group.host}:#{path}").run
      yield(path)
    end
  end
end

class Maintainer
  attr_reader :request
  
  def initialize(request)
    @request = request
    
    @group = Server::Group.new(
      request.group_name,
      request.cluster.host,
      request.state.to_sym,
      request.project.state.to_sym
    )
    
    @users, @keys = [], []
    
    request.project.accounts.each do |a|
      user = Server::User.new(
        a.username,
        @group,
        a.access_state.to_sym,
        a.cluster_state.to_sym
      )
      @users << user
      a.user.credentials.each do |c|
        @keys << Server::Key.new(
          c.public_key,
          user,
          c.state.to_sym
        )
      end
    end
  end
  
  def maintain!
    p "Maintain #{@request.id}"
    if @group.project_state == :active
      p "Project is active"
      case @group.request_state
      when :active
        p "Request is active"
        @users.each do |user|
          if user.allowed?
            p "User is allowed"
            user.ensure_activing
            @keys.each &:synchronize
          else
            p "User is disallowed"
            user.ensure_blocking
          end
        end
      when :blocked, :closed
        @users.each &:ensure_blocking
      end
    else
      @group.ensure_closing
      @users.each &:ensure_closing
    end
  end
end
