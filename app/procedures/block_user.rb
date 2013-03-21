class BlockUser < UserProcedure
  def perform
    @comment = "ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/block_user #{user_login}"
    `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/block_user #{user_login}`
    $?.exitstatus == 0
  end
end
