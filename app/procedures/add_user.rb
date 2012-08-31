class AddUser < Procedure
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
