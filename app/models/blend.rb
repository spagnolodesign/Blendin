class Blend < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :message, length: { maximum: 280 }, presence: true
  validates :recipient, presence: true

  after_create :send_blend_request_email
  after_update :send_status_update_email




  private

  def send_blend_request_email
    BlendMailer.blend_request_email(self).deliver
  end

  def send_status_update_email
    case self.status
      when 'accepted'
        BlendMailer.blend_accepted_email(self).deliver
      when 'rejected'
        BlendMailer.blend_rejected_email(self).deliver
    end
  end
end
