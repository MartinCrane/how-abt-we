class Location < ApplicationRecord
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  include LocationAPI

end
