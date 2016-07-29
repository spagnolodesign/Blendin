class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create :match


  def match
    UserMailer.new_berry_email(self.user_id, self.chat_room_id).deliver_later
  end

end
