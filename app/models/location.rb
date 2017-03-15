class Location < ApplicationRecord
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

  def update_api_data
    self.reformat_address
    self.gather_api_location_data
    self.save
  end
end
