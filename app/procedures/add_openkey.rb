require 'shellwords'
require 'cocaine'

class AddOpenkey < KeyProcedure
  def perform
    @comment="Add key: #{user_login} / #{project_login} on #{host} with #{public_key}.\n"

    key=public_key.shellescape

#    @comment += `ssh -i #{SSH_KEY_PATH}/key octo@#{host} sudo /usr/octo/add_openkey '#{user_login}' '#{key}'`
    line=Cocaine::CommandLine.new('ssh', '-i', "#{SSH_KEY_PATH}/key", "octo@#{host}",
                                  'sudo', '/usr/octo/add_openkey', user_login, key)
    begin
      @comment << line.run
    rescue Cocaine::ExitStatusError => e
      @comment << "ERROR: #{e.inspect} (#{e.message})"
      return false
    end

    true
  end
end
