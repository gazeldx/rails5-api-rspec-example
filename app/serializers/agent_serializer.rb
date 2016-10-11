class AgentSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :description, :created_at

  has_many :tickets

  link(:self) { agent_url(object) }
end