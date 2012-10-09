class RemoteClusterUser
  attr_reader :result
  
  def run(params)
    cu = ClusterUser.find(params[:page][%r{/cluster_users/(\d+)}, 1])
    @result = get_users.include?(cu.username)
  end
  
private
  
  def get_users
    raw.each_line.map do |line|
      line[/(\w+):/, 1]
    end
  end
  
  def raw
    if ENV['OCTOSHELL_ENV'] == 'development'
      File.read(File.expand_path('../../../spec/data/passwd', __FILE__))
    else
      cmd = Cocaine::CommandLine.new('ssh', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru cat /etc/passwd")
      cmd.run
    end
  end
end