class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @my_events = current_user.events.order("date DESC") if user_signed_in?
    @community_events = Event.community_events(@my_events)
    @normal_events = Event.normal_events(@my_events)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.community_events = true if params[:community_events]
    if @event.save
      redirect_to events_path
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render action: "edit"
    end
  end

  def destroy

    if @event.delete
      redirect_to events_path
    else
      flash[:notice] = "Problem deleting the event"
    end
  end



  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date, :time, :name, :description, :city, :address, :zip_code, :max_refugee_capacity, :max_local_capacity, :photo, :community_events, :topic)
  end


end
