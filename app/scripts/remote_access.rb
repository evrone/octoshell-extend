class RemoteAccess
  attr_reader :result
  
  def run(params)
    @access = Access.find(params[:page][%r{/accesses/(\d+)}, 1])
    @result = get_keys.include?(@access.credential.public_key)
  end
  
private
  
  def get_keys
    raw.each_line.map(&:strip)
  end
  
  def raw
    if ENV['OCTOSHELL_ENV'] == 'development'
      File.read(File.expand_path('../../../spec/data/authorized_keys', __FILE__))
    else
      username = @access.cluster_user.username
      exec = "cat /home/#{username}/.ssh/authorized_keys"
      cmd = Cocaine::CommandLine.new('ssh', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru #{exec}")
      cmd.run
    end
  end
end
