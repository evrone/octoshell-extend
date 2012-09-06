class User < ActiveRecord::Base
  has_many :accounts, inverse_of: :user
  has_many :credentials
  has_many :requests
  has_many :owned_projects, class_name: :Project
  has_many :projects, through: :accounts
  has_many :memberships
  has_many :sureties
  has_many :organizations, through: :sureties
  has_many :accesses, through: :credentials
  has_many :tickets
end
