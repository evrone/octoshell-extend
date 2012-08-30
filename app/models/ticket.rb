class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_question
  belongs_to :project
  belongs_to :cluster
  has_many :replies
  has_many :ticket_field_values
  has_many :ticket_tag_relations
end
