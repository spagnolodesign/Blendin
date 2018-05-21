class Partecipant < ApplicationRecord
  has_one :user
  belongs_to :event
  validates :user_id, uniqueness: { scope: :event_id,  message: "The user is already registered" }
  validate :can_partecipate?
  after_save :decrese_event_capacity




  def can_partecipate?
    @event = Event.find(event_id)
    @user = User.find(self.user_id)
    if !@event.community_events && @user.local && @event.max_local_capacity > 0
      return true
    elsif !@event.community_events && !@user.local && @event.max_refugee_capacity > 0
      return true
    else
       errors.add(:user_id, "The Event is full!")
    end
  end


  def decrese_event_capacity
    @event = Event.find(self.event_id)
    @user = User.find(self.user_id)
    if !@event.community_events
      @user.local ? (@event.max_local_capacity -= 1) : (@event.max_refugee_capacity -= 1)
      @event.save
    end
  end

  def increase_event_capacity
    @event = Event.find(self.event_id)
    @user = User.find(self.user_id)
    @user.local ? (@event.max_local_capacity += 1) : (@event.max_refugee_capacity += 1)
    @event.save
  end


 end
