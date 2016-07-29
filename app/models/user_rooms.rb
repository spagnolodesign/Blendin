class UserRooms < ApplicationRecord
	belongs_to :user
  belongs_to :chat_room

  ##Create Subscriptions
  #luca.subscriptions.create(event:Event.first)
  
end
