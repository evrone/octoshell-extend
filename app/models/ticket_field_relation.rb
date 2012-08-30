class TicketFieldRelation < ActiveRecord::Base
  belongs_to :ticket_field
  belongs_to :ticket_question
end
