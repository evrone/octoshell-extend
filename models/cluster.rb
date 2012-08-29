class Cluster < ActiveRecord::Base
  has_many :requests
  has_many :cluster_users
  has_many :tickets
  has_many :projects, through: :requests
  has_many :tasks, as: :resource
  has_many :cluster_fields
end
