class ChatRoom < ApplicationRecord
  has_secure_token

  has_many :messages, dependent: :destroy
  
  has_many :subscriptions
  has_many :users, through: :subscriptions

end
