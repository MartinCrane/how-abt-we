class Location < ApplicationRecord
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :formatted_address, uniqueness: true
  has_many :events

  include LocationAPI

end
