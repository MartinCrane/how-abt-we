class Event < ApplicationRecord
  belongs_to :creator, foreign_key: "creator_id", class_name: "Account"
  has_many :partcipants
  has_many :accounts, through: :participants

  has_one :location
  validates :name, presence: true, length: {maximum: 75}
  validates :capacity, numericality:{greater_than: 0}
  # validates :event_date, 

  def self.init_event(user, params)
    # location = Location.find_or_create_by(name: params[:location])

    event = self.new(params)
    event.creator = user
    event
  end
end
