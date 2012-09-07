require 'shellwords'

class AddOpenkey < KeyProcedure

  def perform
    @comment="Add key: #{user_login} / #{project_login} on #{host} with #{public_key}.\n"

    key=public_key.shellescape

    @comment += `ssh -i #{KEY_PATH}/key octo@#{host} sudo /usr/octo/add_openkey '#{user_login}' '#{key}'`

    $?.exitstatus == 0
  end
end
