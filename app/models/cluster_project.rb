class ClusterProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :cluster
  has_many :cluster_users
  has_many :tasks, as: :resource
  has_many :requests
  
  def request
    requests.where(state: 'active').last
  end
end
