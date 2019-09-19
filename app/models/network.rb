class Network < ApplicationRecord

  after_create :send_thankyou_email
  validates :terms_of_service, acceptance: true

  def send_thankyou_email
    NetworkMailer.thank_you_email(self.email).deliver
  end

end
