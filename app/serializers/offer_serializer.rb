class OfferSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :price, :status, :payment, :deal_open_hour, :deal_closed_hour, :quantity, :created_at, :updated_at

  has_one :user
  has_one :item
  has_many :bookings
end
