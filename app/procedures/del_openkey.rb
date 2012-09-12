require 'shellwords'

class DelOpenkey < KeyProcedure
  def perform
    @comment="Del key: #{project_login} on #{host} with #{public_key}.\n"

    escaped_key=public_key.shellescape

    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} sudo /usr/octo/del_openkey #{project_login} '#{escaped_key}'`

    $?.exitstatus == 0
  end
end
