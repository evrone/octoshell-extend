require File.expand_path('../init', __FILE__)

module Cocaine
  def self.build(cmd)
    CommandLine.new 'ssh', "-t -i #{SSH_KEY_PATH} #{cmd}"
  end
end

module Server
  class Group
    attr_reader :host, :name
    
    def initialize(name, host)
      @name = name
      @host = host
    end
  
    def activate
      active? || add_group
    end
    
    def delete
      active? && delete_group
    end
  
  private
  
    def add_group
      cmd = Cocaine.build("octo@#{host} sudo /usr/octo/add_group #{name}")
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
        cmd = Cocaine.build("octo@#{host} cat /etc/group")
        raw = cmd.run
        raw.each_line.map do |line|
          line[/(\w+):/, 1]
        end
      end
    end
    
    def groups!
      @groups = nil
      groups
    end
  end
  
  class User
    def initialize(name, group, active_keys, deleted_keys)
      @name = name
      @group = group
      @keys = keys
    end
    
    def host
      @group.host
    end
    
    def activate
      %{ octo@#{host} sudo /usr/octo/add_user #{user_login} #{project_login}
         octo@#{host} sudo /usr/octo/unblock_user #{name} }.lines.each do |cmd|
        
        Cocaine.build(cmd.strip).run
      end
    end
    
    def block
      %{ octo@#{host} sudo /usr/octo/add_user #{user_login} #{project_login}
         octo@#{host} sudo /usr/octo/block_user #{user_login} }.lines.each do |cmd|
        
        Cocaine.build(cmd.strip).run
      end
    end
    
    def synchronize_keys
      keys.each do |key|
        key_persisted?(key) || add_key(key)
      end
    end
    
    def remove_key(key)
      key_command do |path|
        Cocaine.build "octo@#{host} sudo /usr/octo/del_openkey  #{name} #{path}"
      end
    end
    
    def key_persisted?(key)
      key_command do |path|
        Cocaine.build "octo@#{host} sudo /usr/octo/check_openkey #{name} #{path}"
      end
    end
    
    def add_key(key)
      key_command do |path|
        Cocaine.build "octo@#{host} sudo /usr/octo/add_openkey #{user_login} #{path}"
      end
    end
    
    def key_command(key)
      key = key.shellescape
      path = "/tmp/octo-#{SecureRandom.hex}"
      File.open(path, 'w+') { |f| f.write key }
      Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} #{path} octo@#{host}:#{path}").run
      cmd = yield(path)
      cmd.run
      File.unlink(path)
      cmd.exit_status.zero? || raise
    end
  end
end

class Maintainer
  attr_reader :request
  
  def initialize(request)
    @request = request
  end
  
  def maintain!
    case project.state.to_sym
    when :active, :closing then
      group.activate
      case request.state.to_sym
      when :active then
        users.each &:activate
      when :blocked, :closed then
        users.each &:block
      end
      users.each &:synchronize_keys
    when :closed then
      group.delete
    end
  end
  
  def group
    @group ||= Server::Group.new(request.group_name, cluster.host)
  end
  
  def project
    request.project
  end
  
  def cluster
    request.cluster
  end
  
  def accounts
    request.accounts
  end
  
  def users
    @users ||= begin
      keys = a.user.credentials
      accounts.map { |a| Server::User.new(a.username, group, keys) }
    end
  end
end

loop do
  if request = Request.for_maintain
    m = Maintainer.new(request)
    m.maintain!
  end
  
  sleep 5
end
