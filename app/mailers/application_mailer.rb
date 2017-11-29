class ApplicationMailer < ActionMailer::Base
  default from: 'support@blendinnow.nl'
  layout 'mailer'

  # def default_url_options
  #   { locale: I18n.locale }
  # end

end
