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
    byebug
    render "confirm"
  end

  def create
    byebug
    location = Location.new(location_params)
    #validation
    if !!location.save
      redirect_to location
    else
      flash[:error] = "Location entry invalid. Please supply name and address."
      redirect_to "/locations/new"
    end
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
end
