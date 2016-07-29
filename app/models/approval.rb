class Approval < ApplicationRecord
	belongs_to :user
  belongs_to :event

  ##Create Subscriptions
  #luca.subscriptions.create(event:Event.first)
  
end
