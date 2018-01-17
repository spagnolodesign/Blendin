require_relative 'boot'

require 'rails/all'
require 'action_view'
include ActionView::Helpers::DateHelper

Bundler.require(*Rails.groups)

module Noc
  class Application < Rails::Application
  	config.remove_unused_tags = true
    config.i18n.default_locale = :nl
    config.i18n.fallbacks = true
    config.i18n.available_locales = [:en, :nl]
    config.app_generators.scaffold_controller = :scaffold_controller
  end
end
