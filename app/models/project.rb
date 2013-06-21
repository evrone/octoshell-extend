class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :accounts, inverse_of: :project
  belongs_to :project_prefix
  has_many :tickets
  has_many :cluster_projects
end
