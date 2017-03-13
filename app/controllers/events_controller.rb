class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :destroy]

  def new
    @event = Event.new
  end

  def create
    event = Event.init_event(current_user, event_params)

    if event.valid?
      event.save
      redirect_to event
    else
      # flash[:error]
      render :new
    end
  end

  def show
  end

  private
  def event_params
    params.require(:event).permit(:name, :creator_id, :location_id, :event_date, :start_time, :end_time)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
