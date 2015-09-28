class OfferSerializer < ActiveModel::Serializer
  attributes :id, :price, :status, :payment, :user_id, :deal_open_hour, :deal_closed_hour, :quantity, :created_at, :updated_at
end
