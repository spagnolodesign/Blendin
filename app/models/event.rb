class Event < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :attendees, through: :participants, source: 'user'

  geocoded_by :address
  before_save :geocode
  before_save :check_max_capacity

  mount_uploader :photo, PhotoUploader

  def location
    [city, zip_code, address].compact.join(', ')
  end

  def complete_address
    "#{self.address}, #{self.zip_code} - #{self.city}"
  end


  def self.community_events(my_events = nil)
    if my_events && my_events.any?
      return (Event.order("date ASC").where(community_events: true) - my_events)
    else
      return Event.order("date ASC").where(community_events: true)
    end
  end

  def self.normal_events(my_events = nil)
    if my_events && my_events.any?
      return (Event.order("date ASC").where(community_events: false) - my_events)
    else
      return Event.order("date ASC").where(community_events: false)
    end
  end

  def check_max_capacity
    if self.community_events
      self.max_local_capacity = nil
      self.max_refugee_capacity = nil
    end
  end

  def local_participants
    self.attendees.where(local:true).uniq
  end

  def refugee_participants
    self.attendees.where(local:false).uniq
  end

  def is_available_for_user?(user)
    if (!self.community_events && user.local && self.max_local_capacity.to_i > 0)
      return true
    elsif (!self.community_events && !user.local && self.max_refugee_capacity.to_i > 0)
      return true
    else
      return false
    end
  end
end
