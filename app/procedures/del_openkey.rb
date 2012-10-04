require 'shellwords'

class DelOpenkey < KeyProcedure
  
  def perform
    @comment="Del key: #{project_login} on #{host} with #{public_key}.\n"

    escaped_key=public_key.shellescape

#    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} sudo /usr/octo/del_openkey #{project_login} '#{escaped_key}'`

    path="/tmp/octo-#{rand(MAX_RAND)}"
    File.open(path,'w') do |f|
      f << public_key
    end

    line=Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} #{path} octo@#{host}:#{path}")
    begin
      @comment << line.run
    rescue Cocaine::ExitStatusError => e
      @comment << "ERROR: #{e.inspect} (#{e.message})"
      File.unlink(path)
      return false
    end
    File.unlink(path)

    line=Cocaine::CommandLine.new('ssh', "-i #{SSH_KEY_PATH} octo@#{host} sudo /usr/octo/add_openkey  #{user_login} #{path}")
    begin
      @comment << line.run
    rescue Cocaine::ExitStatusError => e
      @comment << "ERROR: #{e.inspect} (#{e.message})"
      return false
    end

    $?.exitstatus == 0
  end
end
