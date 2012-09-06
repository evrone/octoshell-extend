class ClusterUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :cluster_project
  has_many :accesses
  has_many :tasks, as: :resource
end
