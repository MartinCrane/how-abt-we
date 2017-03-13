class Event < ApplicationRecord
  belongs_to :creator, foreign_key: "creator_id", class_name: "Account"
  has_many :partcipants
  has_many :comments
  has_many :accounts, through: :participants
  belongs_to :location

  has_one :location
  validates :name, presence: true, length: {maximum: 75}
  validates :capacity, numericality:{greater_than: 0}
  validate :after_today, :start_end
  # validates :event_date,

  def self.find_by_date(date, account=nil)
    if account
      account.events.where(event_date: date) + account.hostings.where(event_date: date)
    else
      Event.where(event_date: date)
    end
  end

  def self.init_event(user, params)
    # location = Location.find_or_create_by(name: params[:location])

    event = self.new(params)
    event.creator = user
    event
  end

  private

  def after_today
    if event_date && event_date < Date.today
      errors.add(:event_date, "can't be in the past")
    end
  end

  def start_end
    if start_time && end_time && start_time > end_time
      errors.add(:start_time, "can't be after the end time")
    end
  end
end
