class LocationsController < ApplicationController
  before_action :require_login
  before_action :set_location, only: [:show, :edit, :destroy]
  before_action :set_key, only: [:show]
  before_action :set_account, only: [:show, :edit, :update, :favorites]


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
    store_temp_location(location)
    render "confirm"
  end

  def create
    location = Location.new(location_params)
    unless location.did_user_edit?(temp_location)
      location.reformat_address
      location.gather_api_location_data
      flash[:error] = "Thank you. Does this look correct?"
      store_temp_location(location)
      @location=location
      render "confirm"
      return
    end
    if location.save
      clear_temp_location
      redirect_to location
    else
      flash[:error]=location.errors.full_messages[0]
      @location=location
      render "confirm"
      return
    end
  end

  def show

  end

  def edit
    respond_to :html, :js
    @user = current_user
  end

  def update
    @location = Location.find_by(id: params[:id])
    if update_favorite?
      redirect_to @location
      return
    end
    @location.update_location(location_params)
    if @location.save
      flash[:message] = "Location has been updated."
      redirect_to @location
    else
      flash[:message] = @location.errors
      redirect_to edit_location_path(@location)
    end
  end

  def favorites
    @locations = @account.fav_locations
    render :favorites
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

  def store_temp_location(location)
    session[:temp_location] = location
  end

  def clear_temp_location
    session.delete(:temp_location)
  end

  def temp_location
    session[:temp_location]
  end

  def clear_flash_errors
    flash[:error] = ''
  end

  def set_account
    @account = Account.find(session[:account_id])
  end

  def update_favorite?
    if !params[:favorite].nil?
      if params[:favorite] == "true"
        @account.fav_locations << @location
      else
        @account.fav_locations.delete(@location)
      end
      return true
    else
      return false
    end
  end
end
