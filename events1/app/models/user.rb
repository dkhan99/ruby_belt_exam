class User < ActiveRecord::Base
  belongs_to :state
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :event_rosters, dependent: :destroy
  has_many :events_attending, through: :event_rosters, dependent: :destroy

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first_name, :last_name, presence: true, length: { in: 2..20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :city, presence: true
	# validates :age, presence: true, numericality: { greater_than: 10, less_than: 150}


end
