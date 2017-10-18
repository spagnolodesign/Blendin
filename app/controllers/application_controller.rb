class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :terms_and_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_street_address, :birthday, :gender, :about, :job, :local, :languages, :country, :education])
  end

end
