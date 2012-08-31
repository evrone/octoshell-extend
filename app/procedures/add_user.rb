class AddUser < Procedure
  def perform
    @comment="User not added - I don't like it"
    host=@task.resource.cluster_user.cluster.host
    user=@task.resource.cluster_user.user
    false
  end
end
