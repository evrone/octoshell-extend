class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :accounts
  belongs_to :project, inverse_of: :accounts
  has_many :cluster_users
  
  def login
    "#{project.project_prefix}#{username}"
  end
end
