class Request < ActiveRecord::Base
  has_many :request_properties
  belongs_to :user
  belongs_to :cluster_project
end
