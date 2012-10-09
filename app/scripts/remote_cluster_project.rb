class RemoteClusterProject
  attr_reader :result
  
  def run(params)
    cp = ClusterProject.find(params[:page][%r{/cluster_projects/(\d+)}, 1])
    groups = get_groups
    @result = groups.include?(cp.username)
  end
  
private
  
  def get_groups
    raw.each_line.map do |line|
      line[/(\w+):/, 1]
    end
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