class Blend < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :message, length: { maximum: 280 }, presence: true
  validates :recipient, presence: true
end
