class EventSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_name, :event_description, :event_date, :event_time, :created_at, :updated_at
  has_one :user
end
