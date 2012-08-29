class TicketTagRelation < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_tag
end
