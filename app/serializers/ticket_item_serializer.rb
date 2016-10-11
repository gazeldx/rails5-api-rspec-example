class TicketItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :state, :ticket_id, :agent_id, :created_at, :updated_at
end