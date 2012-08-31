class AddUser < Procedure

  def perform
    @comment="Add user: #{user_login}, #{project_login} on #{host}"
    #host=@task.resource.cluster_user.cluster.host
    #user=@task.resource.cluster_user.user
    false
  end

  def host
    cluster.host
  end
  
  def project_login
    project.username
  end
  
  def user_login
    account.username
  end
  
  def public_key
    credential.public_key
  end
  
  def additional_attributes
    Hash[request.request_properties.map { |p| [p.name.to_sym, p.value] }]
  end
  
private
  
  def cluster
    task.resource.cluster_user.cluster
  end
  
  def request
    cluster_user.request
  end
  
  def project
    request.project
  end
  
  def user
    credential.user
  end
  
  def cluster_user
    access.cluster_user
  end
  
  def access
    task.resource
  end
  
  def account
    Account.where(state: 'active', project_id: project.id, user_id: user.id).first
  end
  
  def credential
    task.resource.credential
  end

end
