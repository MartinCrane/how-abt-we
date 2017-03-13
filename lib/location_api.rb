module LocationAPI

  require 'rest-client'
  require 'json'

  def reformat_address
      self.address = self.street_number.to_s + " " + self.road + " "+ self.city
  end

  def googe_api_fetch
    googe_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    google_api_key = ENV["google_key"]
    @location_data =  JSON.parse(RestClient.get(googe_url + self.address + "&"+google_api_key))
  end

  def gather_api_location_data
    googe_api_fetch
    address = @location_data["results"][0]["address_components"]
    address.each do |item|
      hash_address = item["types"]
      if hash_address.include?("street_number")
        self.street_number = item["long_name"]
      elsif hash_address.include?("route")
        self.road = item["long_name"]
      elsif hash_address.include?("administrative_area_level_1") &&
            hash_address.include?("political")
        self.state = item["long_name"]
      elsif hash_address.include?("sublocality") &&
            hash_address.include?("political")
        self.city = item["long_name"]
      elsif hash_address.include?("locality") &&
            hash_address.include?("political")
        self.city = item["long_name"]
      elsif hash_address.include?("country") &&
            hash_address.include?("political")
        self.country = item["long_name"]
      else
      end
    end
    #inputs long and lat
    self.latitude = @location_data["results"][0]["geometry"]["location"]["lat"]
    self.longitude = @location_data["results"][0]["geometry"]["location"]["lng"]
    self.formatted_address = @location_data["results"][0]["formatted_address"]
  end
end
