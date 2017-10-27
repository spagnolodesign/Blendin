class HomeController < ApplicationController
	before_action :authenticate_user!
	before_action :allow

	def index
		@users = User.all.near([current_user.latitude, current_user.longitude], 7)
						 .where(local: !current_user.local)
						 .tagged_with(current_user.tags, :any => true)
						 .for_age_range(current_user.age - 4, current_user.age + 4)
						 .where.not(id: current_user.id).order(created_at: :desc)
						 .page params[:page]
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
