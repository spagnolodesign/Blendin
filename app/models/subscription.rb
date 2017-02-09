class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  #after_create :match

  validates_presence_of :chat_room_id
  validates_presence_of :members


  # def match
  #   UserMailer.match_email(self.user, self.chat_room.token).deliver_later
  # end

end
