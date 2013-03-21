class UnblockUser < UserProcedure
  def perform
    @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/unblock_user #{user_login}`
    $?.exitstatus == 0
  end
end
