class BlendMailer < ApplicationMailer

  def blend_request_email(blend_id)
    @blend = Blend.find(blend_id)
    @sender = @blend.sender
    @recipient = @blend.recipient
    mail(to: @recipient.email, subject: "You have a new Blend request!")
  end

  def blend_accepted_email(blend_id)
    @blend = Blend.find(blend_id)
    @sender = @blend.sender
    @recipient = @blend.recipient

    mail(to: @sender.email, subject: "Your Blend request was accepted!")
  end

  def blend_rejected_email(blend_id)
    @blend = Blend.find(blend_id)
    @sender = @blend.sender
    @recipient = @blend.recipient

    mail(to: @sender.email, subject: "Sorry, your Blend request was declined")
  end

end
