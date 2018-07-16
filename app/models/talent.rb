class Talent < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 200 }, presence: true
  validates :description, length: { maximum: 10000 }, presence: true
  validates :category, length: { maximum: 50 }

  mount_uploader :picture, PictureUploader
end
