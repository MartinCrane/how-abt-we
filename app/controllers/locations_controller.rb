class LocationsController < ApplicationController
  before_action :require_login
  before_action :set_location, only: [:show, :edit, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def confirm
    location = Location.new(location_params)
    location.gather_api_location_data
    @location = location
    #save user input to compare against confirm page's address
    session[:temp_location] = @location
    render "confirm"
  end

  def create
    #new object based off of the confirm form
    confirm_location = Location.new(location_params)
    #compare confirm-form response to user's original input
    if compare_location_info(session[:temp_location], confirm_location)
      confirm_location.save
      session[:temp_location] = {}
      redirect_to confirm_location
    else
      #hit API to update edited address information
      confirm_location.reformat_address
      confirm_location.gather_api_location_data
      @location=confirm_location
      session[:temp_location] = @location
      flash[:error] = "updated location"
      render "confirm"
      return
    end
  end

  def show
  end

  def edit
  end

  def update
    location = Location.find_by(id: params[:id])
    #create new ruby object based on edit-form response
    new_location = Location.new(location_params)
    new_location.reformat_address
    new_location.gather_api_location_data
    #create a hash for edit form response that includes google API data
    new_location_params = update_hash(new_location)
      if location.update(new_location_params) #validates address uniqueness
        flash[:message] = "Location has been updated."
        redirect_to location
      else
        flash[:error] = "Address " + location.errors.messages[:formatted_address][0]
        redirect_to edit_location_path
      end
  end

  def destroy
    Location.destroy(@location)
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude, :road, :city, :street_number, :formatted_address, :country, :state)
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def compare_location_info(argument1,argument2)
    argument1["street_number"] == argument2.street_number &&
    argument1["road"] == argument2.road &&
    argument1["state"] == argument2.state &&
    argument1["country"] == argument2.country
  end

  def update_hash(location_object)
    hash = {}
    hash[:street_number] = location_object.street_number
    hash[:road] = location_object.road
    hash[:formatted_address] = location_object.formatted_address
    hash[:latitude] = location_object.latitude
    hash[:longitude] = location_object.longitude
    hash[:state] = location_object.state
    hash[:country] = location_object.country
    hash[:name] = location_object.name
    hash
  end
end
