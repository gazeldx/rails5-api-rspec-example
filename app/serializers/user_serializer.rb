class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :full_name, :password_digest, :description
end
