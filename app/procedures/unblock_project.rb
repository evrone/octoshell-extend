class UnblockProject < ProjectProcedure
  def cluster_user_logins
    cluster_project.cluster_users.pluck(:username)
  end
  
  def perform

    cluster_user_logins.each do |login|
      @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/unblock_user #{login}`

      ret &= $?.exitstatus
    end
    ret
  end
end
