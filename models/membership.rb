class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :positions
end
