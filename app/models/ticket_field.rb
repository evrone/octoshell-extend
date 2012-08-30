class TicketField < ActiveRecord::Base
  has_many :ticket_field_relations
  has_many :ticket_questions, through: :ticket_field_relations
end
