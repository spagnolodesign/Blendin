
class TwilioService
    include Rails.application.routes.url_helpers

  def initialize(blend)
    @blend = blend
    @sender = blend.sender
    @recipient = blend.recipient
    @client = Twilio::REST::Client.new(Rails.application.secrets.TWILIO_ACCOUNT_SID, Rails.application.secrets.TWILIO_AUTH_TOKEN)
    @from = Rails.application.secrets.TWILIO_PHONE
  end

  def message
    if I18n.locale == :en
      "#{@recipient.name}, you have a new Blend request! Are you curious to know who this is? Click here! #{user_url(@sender, locale: :en, host: Rails.application.secrets.HOST)}"
    else
      "#{@recipient.name}, je hebt een nieuw Blend verzoek! Ben je benieuwd wie dit is? Klik dan hier! #{user_url(@sender, locale: :nl, host: Rails.application.secrets.HOST)}"
    end
  end

  def send_sms
    p self.message
    @client.messages.create(
      # to: @recipient.phone,
      to: "+5511981813636",
      from: @from,
      body: self.message
    )
  end
end
