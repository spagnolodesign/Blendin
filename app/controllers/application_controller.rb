class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :set_locale

  # def set_locale
  #   I18n.locale = (params[:locale] || I18n.default_locale).to_sym
  # end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = (params[:locale] || extract_locale_from_accept_language_header).to_sym
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def default_url_options
  { locale: I18n.locale }
  end

  def set_admin_locale
    I18n.locale = :en
  end

  def after_sign_out_path_for(resource_or_scope)
    'https://www.blendinnow.nl/'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :terms_and_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_street_address, :birthday, :gender, :about, :job, :local, :languages, :country, :education])
  end

  private
    # Redirect to request is beeing deneid by auth. Following:
      # Its important that the location is NOT stored if:
      # - The request method is not GET (non idempotent)
      # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
      #    infinite redirect loop.
      # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
