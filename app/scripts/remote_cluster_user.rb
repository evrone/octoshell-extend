class RemoteClusterUser
  attr_reader :result
  
  def run(params)
    cu = ClusterUser.find(params[:page][%r{/cluster_users/(\d+)}, 1])
    group = cu.cluster_project.username
    groups = get_groups
    @result = groups[groups] && groups[groups].include?(cu.username)
  end
  
private
  
  def get_groups
    Hash[raw.each_line.map do |line|
      parse = line.split(/(\w+):x:(\d+):(.*)/)
      group, raw_users = parse[1], parse[3]
      [group, raw_users.split(',')]
    end]
  end
  
  def raw
    if ENV['OCTOSHELL_ENV'] == 'development'
      File.read(File.expand_path('../../../spec/data/groups', __FILE__))
    else
      cmd = Cocaine::CommandLine.new('ssh', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru cat /etc/group")
      cmd.run
    end
  end
end