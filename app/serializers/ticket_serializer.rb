class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :state, :customer_id, :agent_id, :created_at, :updated_at

  belongs_to :customer
  belongs_to :agent
  has_many :ticket_items

  link(:self) { ticket_url(object) }
end