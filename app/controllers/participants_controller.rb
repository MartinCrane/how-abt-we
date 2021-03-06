class ParticipantsController < ApplicationController

  def create
    event=Event.find(params[:event_id])

    participant=Participant.new(event: event, account: current_user)
    if participant.valid?
      participant.save
      redirect_to event
    else
      flash[:error]=participant.errors.full_messages[0]
      redirect_to event
    end
  end

  def destroy
    event=Event.find(params[:event_id])
    Participant.find_by(event: event, account: current_user).destroy
    redirect_to event
  end

  def update
    participant=Participant.find(params[:id])
    event = Event.find(params[:event_id])
    participant.update(participant_params)
    if participant.valid?
      redirect_to event
    else
      flash[:error]=participant.errors.full_messages[0]
      redirect_to event
    end
  end

  private
  def set_participant

  end

  def participant_params
    params.require(:participant).permit(:attended)
  end
end
