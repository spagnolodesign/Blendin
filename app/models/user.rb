#require 'tag_tinter'

class User < ApplicationRecord

  #Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  #Events and Subscriptions
  has_many :approvals, dependent: :destroy
  has_many :events, -> { uniq }, through: :approvals
  
  #Messages and Chatroom
  has_many :messages, dependent: :destroy
  
  has_many :subscriptions
  has_many :chat_rooms, through: :subscriptions

  has_many :likes, :class_name=>'Knok', :foreign_key=>'from_id'
  has_many :liked, :class_name=>'Knok', :foreign_key=>'to_id'

  acts_as_taggable

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode      
    
  mount_uploader :avatar, AvatarUploader

  #after_update :update_tints

  validates :local, :presence => true

  def name
    username.capitalize
  end

  def picture
    self.avatar
  end

  def likes(user)
    alredyLiked = Knok.where(from_id:self.id, to_id:user.id)
    if !alredyLiked.empty?
      return true
    else
      return false
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.avatar = auth.info.image
    end
  end

  def parse_chache_tag
    if self.cached_tag_list.nil?
      return
    else
      self.cached_tag_list = cached_tag_list.split(' ')
      byebug
    end
  end
  
  private
  def update_tints
    TagTinter.new('#74CED2', 'white').update_tints
  end

end
