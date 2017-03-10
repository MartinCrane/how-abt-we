class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create

    location = Location.new(location_params)
    if !!location.save
      redirect_to location
    else
      flash[:error] = "Location entry invalid. Please supply name and address."
      redirect_to "/locations/new"
    end
  end

  def show
    @location = set_location
  end

  def edit
    @location = set_location
  end

  def update
    location = set_location
    location.update(location_params)
    flash[:message] = "Location has been updated."
    redirect_to location
  end

  def destroy

  end

  private

  def location_params
    params.require(:location).permit(:name, :address)
  end

  def set_location
    Location.find(params[:id])
  end
end
