class User < ActiveRecord::Base

  #Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  acts_as_taggable

  validates :terms_and_conditions, acceptance: true

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode

  mount_uploader :avatar, AvatarUploader

  validates :username, length: { maximum: 25 }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, length: { maximum: 35 }

  scope :for_age_range, -> min, max {
    where("date_part('year', age(birthday)) >= ? AND date_part('year', age(birthday)) <= ?", min, max)
  }


  def name
    username.capitalize.split(",")[0]
  end

  def parse_chache_tag
    if self.cached_tag_list.nil?
      return
    else
      self.cached_tag_list = cached_tag_list.split(' ')
    end
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
