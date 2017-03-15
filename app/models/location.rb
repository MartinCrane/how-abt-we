class Location < ApplicationRecord
  has_many :favorites
  
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :formatted_address, uniqueness: true
  has_many :events

  include LocationAPI

  def compare_location_info(temp_location,new_location)
    temp_location["street_number"] == new_location.street_number &&
    temp_location["road"] == new_location.road &&
    temp_location["state"] == new_location.state &&
    temp_location["country"] == new_location.country
  end

  def did_user_edit?(temp_location)
    compare_location_info(temp_location, self)
  end

  def update_location(params)
    new_location = Location.new
    new_location.update(params)
    new_location.reformat_address
    new_location.gather_api_location_data
    self.name = new_location.name
    self.address = new_location.address
    self.street_number = new_location.street_number
    self.road = new_location.road
    self.city = new_location.city
    self.state = new_location.state
    self.country = new_location.country
    self.latitude = new_location.latitude
    self.longitude = new_location.longitude
    self.formatted_address = new_location.formatted_address
  end
end
