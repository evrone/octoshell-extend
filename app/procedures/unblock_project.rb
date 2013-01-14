class UnblockProject < ProjectProcedure
  def perform

    cluster_user_logins.each do |login|
      @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/unblock_user #{login}`

      ret &= $?.exitstatus
    end
    ret
  end
end
