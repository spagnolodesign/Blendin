# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :facebook, Rails.application.secrets.facebook_key, Rails.application.secrets.facebook_secret,
#   				 :scope => 'email,user_birthday,user_friends'
# end