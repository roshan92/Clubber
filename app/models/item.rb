class Item < ActiveRecord::Base
	belongs_to :user
	has_many :offers

	validates :name, :description, :price, presence: true
end
