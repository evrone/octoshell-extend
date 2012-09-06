class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :positions, inverse_of: :membership
end
