class BlockUser < UserProcedure
  def perform
    @comment = `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/block_user #{user_login}`
    @comment << "\nexitstatus: #{$?.exitstatus}"
    $?.exitstatus == 0
  end
end
