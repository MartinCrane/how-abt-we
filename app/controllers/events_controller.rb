class EventsController < ApplicationController
  before_action :require_login
  before_action :set_key, only: [:show]
  before_action :set_event, only: [:update, :show, :destroy, :edit]

  def index
    @events=Event.all
  end

  def my_events
    @events=current_user.hostings
    render :index
  end

  def attending_events
    @events = current_user.events
    render :index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.init_event(current_user, event_params)
    @event.location = Location.find(event_params[:location_id]) unless event_params[:location_id].empty?
    if @event.save
      redirect_to @event
    else
      flash.now[:error]= @event.errors.full_messages[0]
      render new_event_path
    end
  end

  def show
    @comment=Comment.new
    @comments=Comment.where(event: @event)
    @attending=Participant.exists?(@event, current_user)
    @participant=Participant.new
    @participants=Participant.where(event: @event)
  end

  def edit
    respond_to :html, :js
  end

  def update
    @event.update(event_params)
    @event.location = Location.find(event_params[:location_id]) unless event_params[:location_id].empty?
    if @event.valid?
      redirect_to @event
    else
      flash[:error]=@event.errors.full_messages[0]
      redirect_to @event
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :capacity, :creator_id, :location_id, :event_date, :start_time, :end_time)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
