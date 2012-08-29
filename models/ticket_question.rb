class TicketQuestion < ActiveRecord::Base
  belongs_to :ticket_question
  has_many :ticket_questions
  has_many :ticket_field_relations
  has_many :ticket_fields, through: :ticket_field_relations
end
