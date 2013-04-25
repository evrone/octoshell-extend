require 'cocaine'
require 'shellwords'

module Cocaine
  def self.build(cmd)
    CommandLine.new 'ssh', "-t -i #{SSH_KEY_PATH} #{cmd}"
  end
end

module Server
  class Group
    attr_reader :host, :name, :request_state, :project_state
    
    def initialize(name, host, request_state, project_state)
      @name = name
      @host = 'v2.parallel.ru' # host
      @request_state = request_state
      @project_state = project_state
    end
    
    def synchronize
      case project_state
      when :active
        ensure_activing
      when :closed
        ensure_closing
      end
    end
    
  private
    
    def ensure_activing
      active? || add_group
    end
    
    def ensure_closing
      active? && delete_group
    end
    
    def add_group
      cmd = Cocaine.build("evrone@#{host} sudo /usr/octo/add_group #{name}")
      cmd.run
      cmd.exit_status.zero? || raise
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
        cmd = Cocaine.build("evrone@#{host} cat /etc/group")
        raw = cmd.run
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
      Cocaine.build("evrone@#{group.host} sudo /usr/octo/check_user #{name} #{group.name}").run
    end
    
    def blocked?
      check_user == 'blocked'
    end
    
    def add
      Cocaine.build("evrone@#{group.host} sudo /usr/octo/add_user #{name} #{group.name}").run
    end
    
    def remove
      Cocaine.build("evrone@#{group.host} sudo /usr/octo/del_user #{name} #{group.name}").run
    end
    
    def block
      Cocaine.build("evrone@#{group.host} sudo /usr/octo/block_user #{name}")
    end
    
    def unblock
      Cocaine.build("evrone@#{group.host} sudo /usr/octo/unblock_user #{name}").run
    end
  end
  
  class Key
    attr_reader :user, :state
    
    def initialize(value, user, state)
      @value = value
      @user  = user
      @state = state
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
        Cocaine.build "evrone@#{user.group.host} sudo /usr/octo/del_openkey  #{user.name} #{path}"
      end
    end
    
    def persisted?
      key_command do |path|
        Cocaine.build "evrone@#{user.group.host} sudo /usr/octo/check_openkey #{user.name} #{path}"
      end == 'ok'
    end
    
    def add
      key_command do |path|
        Cocaine.build "evrone@#{user.group.host} sudo /usr/octo/add_openkey #{user.name} #{path}"
      end
    end
    
    def key_command
      key = @value.shellescape
      path = "/tmp/octo-#{SecureRandom.hex}"
      File.open(path, 'wb') { |f| f.write key }
      Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} #{path} evrone@#{user.group.host}:#{path}").run
      cmd = yield(path)
      cmd.run.chomp
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
    if @group.project_state == :active
      case @group.request_state
      when :active
        @users.each do |user|
          if user.allowed?
            user.ensure_activing
            @keys.each &:synchronize
          else
            user.ensure_blocking
          end
        end
        @keys.each &:ensure_activing
      when :blocked, :closed
        @users.each &:ensure_blocking
      end
    else
      @group.ensure_closing
      @users.each &:ensure_closing
    end
  end
end
