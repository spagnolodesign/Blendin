
class TwilioService
    include Rails.application.routes.url_helpers

  def initialize(blend)
    @blend = blend
    @sender = blend.sender
    @recipient = blend.recipient
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @from = ENV['TWILIO_PHONE']
  end

  def message
    if I18n.locale == :en
      "#{@recipient.name}, you have a new Blend request! Are you curious to know who this is? Click here! #{user_url(@sender, locale: :en, host: ENV['MAIN_URL'])}"
    else
      "#{@recipient.name}, je hebt een nieuw Blend verzoek! Ben je benieuwd wie dit is? Klik dan hier! #{user_url(@sender, locale: :nl, host: ENV['MAIN_URL'])}"
    end
  end

  def send_sms
    @client.messages.create(
      # to: @recipient.phone,
      to: "+6282147982860",
      from: @from,
      body: self.message
    )
  end
end
