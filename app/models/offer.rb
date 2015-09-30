class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :item
	has_many :bookings

	validates :item_id, :deal_open_hour, :deal_closed_hour, presence: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # scope :filter_by_title, lambda { |keyword|
  #   where("lower(title) LIKE ?", "%#{keyword.downcase}")
  # }
  scope :above_or_equal_to_price, lambda { |price|
    where("price >= ?", price)
  }

  scope :below_or_equal_to_price, lambda { |price|
    where("price <= ?", price)
  }

  scope :recent, -> {
    order(:updated_at)
  }

  def self.search(params = {})
    offers = params[:offer_ids].present? ? Offer.find(params[:offer_ids]) : Offer.all

    offers = offers.filter_by_title(params[:keyword]) if params[:keyword]
    offers = offers.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
    offers = offers.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
    offers = offers.recent(params[:recent]) if params[:recent].present?

    offers
  end

end
