class HomeController < ApplicationController
	#before_action :authenticate_user!
	before_action :auth_user
	before_action :allow, only: [:index]

	def index
		@users = User.match_with(current_user, 7, 10).page params[:page]
		if @users.length <= 10
			@users = User.match_with(current_user, 15, 20).page params[:page]
		end
	end

	def auth_user
		redirect_to new_user_registration_url unless user_signed_in?
	end

	def allow
		if (current_user.latitude.nil? || current_user.latitude.nil?  || current_user.birthday.nil?)
			flash[:notice] = 'Please update the mandatory fields before start blending!'
			redirect_to wizard_path
		end
	end

end
