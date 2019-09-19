class SendSmsJob < ActiveJob::Base
  queue_as :sms

  def perform(blend_id)
    blend = Blend.find(blend_id)
    TwilioService.new(blend).send_sms
  end
end
