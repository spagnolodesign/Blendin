class User < ActiveRecord::Base
  has_many :sent_blends, class_name: 'Blend', foreign_key: 'sender_id'
  has_many :received_blends, class_name: 'Blend', foreign_key: 'recipient_id'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

  acts_as_taggable

  validates :terms_and_conditions, acceptance: true

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode

  mount_uploader :avatar, AvatarUploader

  validates :username, length: { maximum: 26 }, presence: true
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

  def blended?(user)
    user = User.find(user.id)
    i_blend = Blend.where(sender: self, recipient:user)
    blend_to_me = Blend.where(sender: user, recipient:self)

    if i_blend.any?
      return {status: "SENT", data:i_blend.first}
    elsif blend_to_me.any?
      return {status: "RECIVED", data:blend_to_me.first}
    else
      return false
    end
  end


  def blends
    Blend.where("sender_id = ? OR recipient_id = ?", self.id, self.id).count
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

end
