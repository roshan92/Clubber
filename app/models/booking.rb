class Booking < ActiveRecord::Base
	belongs_to :offer
	belongs_to :user

	validate :booking_quantity_cannot_be_greater_than_total_quantity

	validates :quantity, presence: true

	after_save :update_offer_quantity, :update_offer_status

	before_destroy :before_destroy_add_quantity_to_offer

	def update_offer_quantity
		final_quantity = offer.quantity.to_i - self.quantity.to_i
		offer.update_attributes(quantity: final_quantity)	
	end

	def before_destroy_add_quantity_to_offer
		after_destroy_quantity = self.quantity.to_i + offer.quantity.to_i
		offer.update_attributes(quantity: after_destroy_quantity)	
	end

	protected

	def booking_quantity_cannot_be_greater_than_total_quantity
  	if self.quantity.to_i > offer.quantity.to_i
      errors.add(:quantity, "can't be greater than total quantity")
    end
  end

	def update_offer_status
		if offer.quantity.to_i.nil?
			offer.update_attributes(status: false)
		end
	end

end
