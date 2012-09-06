class Procedure
  attr_reader :task, :comment
  
  def initialize(task)
    @task = task
    @comment = ""
  end
  
  def perform
    raise "Implement Me!"
  end
end

class UserProcedure < Procedure
  KEY_PATH='/home/serg/Work/Octoshell/octoshell-extend'

  def host
    cluster.host
  end

  def project_login
    project.username
  end

  def additional_attributes
    Hash[request.request_properties.map { |p| [p.name.to_sym, p.value] }]
  end

private

  def cluster
    cluster_user.cluster
  end
  
  def project
    cluster_user.project
  end
  
  def cluster_user
    task.resource
  end
  
  def request
    cluster_user.request
  end
end

class KeyProcedure < Procedure
  KEY_PATH='/home/serg/Work/Octoshell/octoshell-extend'

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
    cluster_user.cluster
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
