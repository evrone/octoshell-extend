class Task < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :task
  has_many :tasks
end
