class HomeController < ApplicationController
	#before_action :authenticate_user!
	before_action :auth_user
	before_action :allow, only: [:index]

	def index
		@users = User.match_with(current_user).page params[:page]
	end

	def auth_user
		redirect_to new_user_registration_url unless user_signed_in?
	end

	def allow
		if (current_user.latitude.nil? || current_user.latitude.nil?  || current_user.age.nil?)
			redirect_to wizard_path
		end
	end

end
