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
    session[:temp_location] = @location

    render "confirm"
  end

  def create
    confirm_location = Location.new(location_params)

    #is edited info differetn than first search?
    if compare_location_info(session[:temp_location], confirm_location)
      confirm_location.save
      session[:temp_location] = {}
      redirect_to confirm_location
    else
      confirm_location.reformat_address
      confirm_location.gather_api_location_data
      @location=confirm_location
      session[:temp_location] = @location
      flash[:error] = "updated location"
      render "confirm"
      return
    end
    # flash[:error] = "Location entry invalid. Please supply name and address."
  end

  def show
  end

  def edit
  end

  def update
    location = set_location
    location.update(location_params)
    flash[:message] = "Location has been updated."
    redirect_to location
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
end
