class UserSerializer < ActiveModel::Serializer
  # embed :ids
  attributes :id, :email, :created_at, :updated_at, :auth_token, :first_name, :last_name, :deleted_at, :type

  has_many :offers
  has_many :bookings
  has_many :items
  has_many :events, :foreign_key => "user_id", dependent: :destroy
  has_many :invites, :foreign_key => "guest_id", dependent: :destroy
  has_many :attended_events, through: :invites, dependent: :destroy
end
