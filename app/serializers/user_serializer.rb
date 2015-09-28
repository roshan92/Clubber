class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token, :first_name, :last_name, :deleted_at, :type
end
