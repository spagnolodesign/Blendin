class Message < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  self.per_page = 15

  def timestamp
   created_at.to_s(:time) 
  end

end
