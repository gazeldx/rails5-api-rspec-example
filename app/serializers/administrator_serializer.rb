class AdministratorSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :description, :created_at
end