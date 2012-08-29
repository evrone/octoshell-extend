class Credential < ActiveRecord::Base
  has_many :accesses
  belongs_to :user
end
