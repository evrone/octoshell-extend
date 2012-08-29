class TicketFieldValue < ActiveRecord::Base
  belongs_to :ticket_field_relation
  belongs_to :ticket
end
