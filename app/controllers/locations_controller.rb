class LocationsController < ApplicationController
  before_action :require_login
  before_action :set_location, only: [:show, :edit, :destroy]
  before_action :set_key, only: [:show]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def confirm
    location = Location.new(location_params)
    location.gather_api_location_data
    @location=location
    store_temp_location
    render "confirm"
  end

  def create
    clear_flash_errors
    location = Location.new(location_params)
    location.did_user_edit?(session[:temp_location])
    if location.save
      clear_temp_location
      redirect_to location
    else
      flash[:error] = "Location already exists, bro"
      @location=location
      render "confirm"
      return
    end
  end

  def show
  end

  def edit
    respond_to :html, :js
  end

  def update
    location = Location.find_by(id: params[:id])
    if location.update(location_params)
      location.update_api_data
      flash[:message] = "Location has been updated."
      redirect_to location
    else
      flash[:message] = location.errors
      redirect_to edit_location_path(location)
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

  def set_key
    @key = ENV["google_key2"]
  end

  def store_temp_location
    session[:temp_location] = @location
  end

  def clear_temp_location
    session.delete(:temp_location)
  end

  def clear_flash_errors
    flash[:error] = ''
  end
end
