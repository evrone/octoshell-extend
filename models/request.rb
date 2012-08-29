class Request < ActiveRecord::Base
  has_many :request_properties
  belongs_to :project
  belongs_to :cluster
  belongs_to :user
end
