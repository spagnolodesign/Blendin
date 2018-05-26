class ParticipantsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @participants = Participant.new(event: @event, user_id: current_user.id)
    if !current_user.is_participant?(@event) && @participants.can_partecipate?
      @participants.save
      flash[:notice] = "Yeee. We can't wait to meet you!"
      redirect_to event_path(@event)
    else
      flash[:alert] = "You can't subscribe to this event"
      redirect_to events_path
    end
  end

  def destroy
    @participants = Participant.find(params[:id])
    @event = @participants.event
    @participants.increase_event_capacity if !@event.community_events
    if @participants.delete
      redirect_to events_path
    else
      flash[:alert] = "error"
      redirect_to events_path
    end
  end

end
