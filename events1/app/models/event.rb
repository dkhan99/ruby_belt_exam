class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  belongs_to :state
  has_many :event_rosters, dependent: :destroy
  has_many :users, through: :event_rosters, dependent: :destroy

  validates :name, :city, presence: true, length: { in: 2..20 }
  validates :date, presence: true 
 
  validate :future_date
  
  private
  def future_date
    return if date.blank?
    if date < DateTime.now
      errors.add(:future_date, "is required")
    end
  end



  # validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  # validates :city, presence: true
  # validates :age, presence: true, numericality: { greater_than: 10, less_than: 150}

#   validate :future_event

#   private

#   def future_event
#     errors.add(:date, "Can't be in the past!") if params[:event][:date] < Time.now
#   end  
end
