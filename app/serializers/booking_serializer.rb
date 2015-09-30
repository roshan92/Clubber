class BookingSerializer < ActiveModel::Serializer
  attributes :offer_id, :quantity, :amount, :user_id, :paid, :paid_on, :created_at, :updated_at
  has_one :user
end
