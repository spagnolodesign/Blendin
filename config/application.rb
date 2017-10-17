require_relative 'boot'

require 'rails/all'
require 'action_view'
include ActionView::Helpers::DateHelper


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Noc
  class Application < Rails::Application

  	config.remove_unused_tags = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
