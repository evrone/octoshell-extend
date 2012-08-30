class TicketTag < ActiveRecord::Base
  has_many :ticket_tag_relations, dependent: :destroy
  has_many :tickets, through: :ticket_tag_relations
end
