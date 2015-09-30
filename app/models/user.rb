class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true
  validates :first_name, :last_name, :email, presence: true

  before_create :generate_authentication_token!

  has_many :offers
  has_many :bookings
  has_many :items
  has_many :events, :foreign_key => "user_id", dependent: :destroy
  has_many :invites, :foreign_key => "guest_id", dependent: :destroy
  has_many :attended_events, through: :invites, dependent: :destroy

  TYPE = %w(Guest Manager Admin Organizer VIP)

  def is_admin?
    type === 'Admin'
  end

  def is_manager?
    type === 'Manager'
  end

  def is_vip?
    type === 'VIP'
  end

  def is_guest?
    type === 'Guest'
  end

  def is_organizer?
    type === 'Organizer'
  end

  def is_owner?(klass)
    if klass.class.model_name === 'Item'
      id === klass.user_id
    elsif klass.class.model_name === 'Offer'
      id === klass.user_id
    elsif klass.class.model_name === 'Booking'
      id === klass.user_id
    elsif klass.class.model_name === 'Event'
      id === klass.user_id
    elsif klass.class.model_name === 'Invite'
      id === klass.user_id
    else
      false
    end
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private

	def set_default_type
  	self.becomes(Guest)
  end
end
