class Access < ActiveRecord::Base
  belongs_to :cluster_user
  belongs_to :credential
  has_many :tasks, as: :resource
end
