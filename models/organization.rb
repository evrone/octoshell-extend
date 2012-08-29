class Organization < ActiveRecord::Base
  has_many :sureties
  has_many :projects
  has_many :users, through: :sureties
  has_many :memberships
  belongs_to :organization_kind
end
