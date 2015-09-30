class EventSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_name, :event_description, :event_date, :event_time, :created_at, :updated_at

  has_one :user
  has_many :guests, through: :invites
	has_many :invites, :foreign_key => 'attended_event_id'
end
