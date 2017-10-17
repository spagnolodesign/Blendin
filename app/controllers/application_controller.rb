class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  # def after_sign_in_path_for(resource)
  # 	if resource.sign_in_count == 1 || resource.tag_list.empty?
  # 		tag_users_path(resource)
  # 	else
  #   	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  # 	end
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :terms_and_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_street_address, :birthday, :gender, :about, :job, :local, :languages, :country, :education])
  end

end
# This file is auto-generated from the current state of the database. Instead
