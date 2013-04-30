require 'cocaine'
require 'shellwords'
require 'net/ssh'

module Server
  class Fail < StandardError
    def initialize(cmd, msg = "")
      @cmd = cmd
      @msg = msg
    end
    
    def to_s
      message
    end
    
    def message
      "Failed command: #{@cmd}.\nOut: #{@msg}"
    end
  end
  
  class Connection
    def initialize(host, user = 'octo', keys = [SSH_KEY_PATH])
      @host = host
      @user = user
      @keys = keys
    end
    
    def log(msg)
      Thread.current[:cluster].log(msg)
    end
    
    def run(cmd)
      res = ""
      ::Net::SSH.start(@host, @user, keys: @keys) do |ssh|
        log "command: #{cmd}"
        ssh.open_channel do |channel|
          channel.request_pty do |ch, success|
            ch.exec cmd
          end
          channel.on_data do |ch, data|
            res = data.chomp
          end
        end
      end
      log "result: #{res}"
      res
    end
  end
  
  class Group
    attr_reader :host, :name, :request_state, :project_state
    
    def initialize(name, host, request, project)
      @name = name
      @host = host
      @request_state = request.state.to_sym
      @project_state = project.state.to_sym
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
      cmd = "sudo /usr/octo/add_group #{name}"
      out = @connection.run(cmd)
      out == 'ok' || raise(Fail.new(cmd, out))
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
      cmd = "sudo /usr/octo/check_user #{name} #{group.name}"
      out = @connection.run(cmd)
      %w(active closed blocked).include?(out) || raise(Fail.new(cmd, out))
      out
    end
    
    def blocked?
      check_user == 'blocked'
    end
    
    def add
      cmd = "sudo /usr/octo/add_user #{name} #{group.name}"
      out = @connection.run(cmd)
      out == 'ok' || raise(Fail.new(cmd, out))
      out
    end
    
    def remove
      cmd = "sudo /usr/octo/del_user #{name}"
      out = @connection.run(cmd)
      out == 'ok' || raise(Fail.new(cmd, out))
      out
    end
    
    def block
      cmd = "sudo /usr/octo/block_user #{name}"
      out = @connection.run(cmd)
      out == 'ok' || raise(Fail.new(cmd, out))
      out
    end
    
    def unblock
      cmd = "sudo /usr/octo/unblock_user #{name}"
      out = @connection.run(cmd)
      out == 'ok' || raise(Fail.new(cmd, out))
      out
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
      cmd = ""
      out = key_command do |path|
        cmd = "sudo /usr/octo/del_openkey #{user.name} #{path}"
        @connection.run(cmd)
      end
      out == 'ok' || raise(Fail.new(cmd, out))
    end
    
    def persisted?
      cmd = ""
      out = key_command do |path|
        cmd = "sudo /usr/octo/check_openkey #{user.name} #{path}"
        @connection.run(cmd)
      end
      ['not found', 'found'].include?(out) || raise(Fail.new(cmd, out))
      out == 'found'
    end
    
    def add
      cmd = ""
      out = key_command do |path|
        cmd = "sudo /usr/octo/add_openkey #{user.name} #{path}"
        @connection.run(cmd)
      end
      out == 'ok' || raise(Fail.new(cmd, out))
    end
    
    def key_command
      key = @value
      path = "/tmp/octo-#{SecureRandom.hex}"
      File.open(path, 'wb') { |f| f.write key }
      Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} #{path} octo@#{user.group.host}:#{path}").run
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
      request,
      request.project
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
        @keys << Server::Key.new(c.public_key, user, c.state.to_sym)
      end
    end
  end
  
  def log(msg)
    Thread.current[:cluster].log(msg)
  end
  
  def maintain!
    log "Maintain #{@request.id}"
    if @group.project_state == :active
      log "Project is active"
      case @group.request_state
      when :active
        log "Request is active"
        @users.each do |user|
          if user.allowed?
            log "User is allowed"
            user.ensure_activing
            @keys.find_all { |k| k.user == user }.each &:synchronize
          else
            log "User is disallowed"
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
