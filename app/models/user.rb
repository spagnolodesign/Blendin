#require 'tag_tinter'

class User < ApplicationRecord

  #Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  
  #Messages and Chatroom
  has_many :messages, dependent: :destroy
  
  has_many :subscriptions
  has_many :chat_rooms, through: :subscriptions

  has_many :likes, :class_name=>'Knok', :foreign_key=>'from_id'
  has_many :liked, :class_name=>'Knok', :foreign_key=>'to_id'

  acts_as_taggable
  acts_as_taggable_on :available

  acts_as_reader

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode      
    
  mount_uploader :avatar, AvatarUploader

  validates :username, length: { maximum: 25 }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, length: { maximum: 35 }
  validates :job, length: { maximum: 25 }
  validates :languages, length: { maximum: 255 }

  self.per_page = 9

  def name
    username.capitalize.split(",")[0]
  end

  def short_name
    username.capitalize.split(" ")[0]
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
    end
  end

  def country_name
    if (country.blank?) 
      return
    end
    cname = ISO3166::Country[country]
    cname.translations[I18n.locale.to_s] || cname.name
  end

  def age
    if (birthday.blank?)
      return
    end
    dob = self.birthday
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
end
