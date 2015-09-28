class UserSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :email, :created_at, :updated_at, :auth_token, :first_name, :last_name, :deleted_at, :type

  has_many :offers
end
