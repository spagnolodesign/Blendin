class NetworkMailer < ApplicationMailer

  def thank_you_email(email)
    mail(to: email, subject: "Heel erg bedankt voor je aanmelding!")
  end

end
