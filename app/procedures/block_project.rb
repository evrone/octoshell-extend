class BlockProject < ProjectProcedure
  def cluster_user_logins
    cluster_project.cluster_users.pluck(:username)
  end

  def perform
    ret=true
    cluster_user_logins.each do |login|
      @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/block_user #{login}`
      ret &= $?.exitstatus
    end
    ret
  end
end
