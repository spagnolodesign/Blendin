
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
    to_phone_number = validate_dutch_phone_number @recipient.phone
    return unless to_phone_number.length == 12
    @client.messages.create(
      to: to_phone_number,
      from: '+3197004499273',
      body: self.message
    )
  end

  def validate_dutch_phone_number userphone
    valid_string = !userphone.nil? && !userphone.empty? && (userphone.length > 0)
    if valid_string
      number = remove_space_and_special_char userphone
      prefix = number[0..1]
      case prefix
        when "00" then prefix = "+"
        when "31" then prefix = "+#{prefix}"
        when "06" then prefix = "+316"
      end
      valid_number = prefix.to_s + number[2..-1].to_s
      return valid_number
    else
      return ""
    end
  end

  def remove_space_and_special_char number
    return number.to_s.scan(/[\d]+/).join
  end

end
