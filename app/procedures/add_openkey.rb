require 'shellwords'
require 'cocaine'

class AddOpenkey < KeyProcedure
  MAX_RAND=1000000000

  def perform
    @comment="Add key: #{user_login} / #{project_login} on #{host} with #{public_key}.\n"

    key=public_key.shellescape
    path="/tmp/octo-#{rand(MAX_RAND)}"

    File.open(path,'w') do |f|
      f << public_key
    end

    line=Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} octo@#{host}:#{path}")
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

    true
  end
end
