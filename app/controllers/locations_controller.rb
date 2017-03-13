class LocationsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :destroy]

  def index
    @locations = Location.all
  end

  def new
    flash[:address_confirm] = nil
    @location = Location.new
  end

  def create

    location = Location.new(location_params)
    #fetch address details and confirm address on rerender. Should this be separate #confirm action?
    unless location.latitude?
      location.gather_api_location_data
      flash[:address_confirm] = "Please confirm the following is the correct address"
      @location = location
      render "new"
      return
    end
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
    params.require(:location).permit(:name, :address)
  end

  def set_location
    @location = Location.find(params[:id])
  end
end
