class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :user_id, :created_at, :updated_at
  has_one :user
end
