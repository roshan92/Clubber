class Offer < ActiveRecord::Base
	belongs_to :user
	# belongs_to :item
	# has_many :bookings

	validates :item_id, :deal_open_hour, :deal_closed_hour, presence: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
