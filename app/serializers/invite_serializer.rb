class InviteSerializer < ActiveModel::Serializer
  attributes :id, :attended_event_id, :guest_id
  has_one :user
end
