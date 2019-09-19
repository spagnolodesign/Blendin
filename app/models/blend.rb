class Blend < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :message, length: { maximum: 280 }, presence: true
  validates :recipient, presence: true
  validates_uniqueness_of :recipient_id, scope: :sender_id
  validate :blended_already

  # after_create :sms_and_email_notification
  # after_update :send_status_update_email


  STATES = [
    :pending,
    :accepted,
    :declined,
    :closed
  ].freeze

  def sms_and_email_notification
    BlendMailer.blend_request_email(self.id).deliver_later
    return if self.recipient_has_not_mobile?
    SendSmsJob.perform_later(self.id)
  end

  def send_pending_blend_email_reminder
    BlendMailer.blend_request_email(self.id).deliver_later
  end

  def recipient_has_not_mobile?
    if self.recipient.phone.nil?
      true
    elsif (self.recipient.phone.empty? || self.recipient.phone.length < 5)
      true
    else
      false
    end
  end

  private

  def blended_already
    if Blend.where("blends.sender_id = ? AND blends.recipient_id = ?", "#{self.recipient_id}", "#{self.sender_id}").count != 0
      errors.add(:recipient, "Already blended")
    end
  end

  def send_status_update_email
    case self.status
      when "accepted"
        BlendMailer.blend_accepted_email(self.id).deliver_later
      when "declined"
        BlendMailer.blend_rejected_email(self.id).deliver_later
      end
    end
end
