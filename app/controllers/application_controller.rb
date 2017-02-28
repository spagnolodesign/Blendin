class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :unread_messages

  
  def unread_messages
  	@count = Message.unread_by(current_user).count.to_s
  end

  def after_sign_in_path_for(resource)
  	if resource.sign_in_count == 1 || resource.tag_list.empty?
  		tag_users_path(resource)
  	else	
    	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  	end
  end

end
