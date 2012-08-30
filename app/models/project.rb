class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :accounts
  has_many :requests
  has_many :tickets
  has_many :cluster_users
end
