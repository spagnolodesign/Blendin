class PartecipantsController < ApplicationController

  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @partecipant = Partecipant.new(event: @event, user_id: current_user.id)
    if !current_user.is_partecipant?(@event) && @partecipant.can_partecipate?
      @partecipant.save
      redirect_to events_path
    else
      flash[:alert] = "You can't subscribe to this event"
      redirect_to events_path
    end
  end

  def destroy
    @partecipant = Partecipant.find(params[:id])
    @event = @partecipant.event
    @partecipant.increase_event_capacity if !@event.community_events
    if @partecipant.delete
      redirect_to events_path
    else
      flash[:alert] = "Problem deleting the partecipation"
      redirect_to events_path
    end
  end

end
