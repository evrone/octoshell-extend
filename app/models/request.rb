class Request < ActiveRecord::Base
  has_many :request_properties
  belongs_to :user
  belongs_to :project
  belongs_to :cluster
  
  def self.for_maintain
    where(%{maintain_requested_at is not null}).
      order("maintain_requested_at asc").first
  end
end
