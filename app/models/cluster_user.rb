class ClusterUser < ActiveRecord::Base
  belongs_to :cluster
  belongs_to :project
  belongs_to :request # last request
  has_many :tasks, as: :resource
  has_many :accesses
end
