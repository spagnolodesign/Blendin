require_relative 'boot'

require 'rails/all'
require 'action_view'
include ActionView::Helpers::DateHelper


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Noc
  class Application < Rails::Application
  	config.web_console.whitelisted_ips = ['10.0.2.2', '0.0.0.0', '127.0.0.1']
  	config.action_cable.allowed_request_origins = [/https?:\/\/localhost:\d+/,'127.0.0.1:3000', '0.0.0.0:3000']
  	config.disable_request_forgery_protection = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
