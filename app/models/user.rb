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
  acts_as_taggable_on :interests

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode      

  def name
    username.capitalize
  end

  def avatar_base
    if gender == "m"
      "https://picturepan2.github.io/spectre/demo/img/avatar-4.png"
    else
      "https://picturepan2.github.io/spectre/demo/img/avatar-5.png"
    end
  end

  def picture
    if self.avatar.nil? || self.avatar.empty?
      avatar_base
    else
      self.avatar
    end
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

end
