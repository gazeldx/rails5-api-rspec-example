class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :token
end