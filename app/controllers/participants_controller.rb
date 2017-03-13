class ParticipantsController < ApplicationController

  def create
    event=Event.find(params[:event_id])
    if current_user!=event.creator
      participant=Participant.new(event: event, account: current_user)
      if participant.valid?
        participant.save
        redirect_to event
      else
        #flash: [error]
        redirect_to event
      end
    else
      #flash - you're the creator of this event
      redirect_to event
    end
  end
end
