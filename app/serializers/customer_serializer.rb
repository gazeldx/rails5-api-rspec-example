class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :description, :created_at

  has_many :tickets

  link(:self) { customer_url(object) }
end