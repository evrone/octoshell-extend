class Cluster < ActiveRecord::Base
  has_many :tickets
  has_many :cluster_fields
  has_many :cluster_projects
end
