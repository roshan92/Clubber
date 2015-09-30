class Event < ActiveRecord::Base
   # belongs_to :user
  belongs_to :user, class_name: 'User'
	has_many :guests, through: :invites, dependent: :destroy
	has_many :invites, :foreign_key => 'attended_event_id', dependent: :destroy
end

# scope	   :upcoming,    -> { where('date >= ?', DateTime.now).order('Date ASC') }
# scope      :past,        -> { where('date < ?', DateTime.now).order('Date DESC') }
