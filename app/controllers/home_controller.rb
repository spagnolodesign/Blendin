class HomeController < ApplicationController
	before_action :authenticate_user!
	before_filter :allow

	def index
		@users = User
							.near([current_user.latitude, current_user.longitude], 20)
							.where(local: !current_user.local)
							.for_age_range(current_user.age - 5, current_user.age + 5)
							.tagged_with(current_user.tags, :any => true)
							.where.not(id: current_user.id).order("RANDOM()").last(10)
		if @users.empty?
			@users = User.near([current_user.latitude, current_user.longitude], 20)
									 .where(local: !current_user.local)
									 .for_age_range(current_user.age - 5, current_user.age + 5)
									 .where.not(id: current_user.id).order("RANDOM()").last(10)
		end

	end

	def auth_user
		redirect_to new_user_registration_url unless user_signed_in?
	end

	def allow
		if (current_user.latitude.nil? || current_user.latitude.nil?)
			redirect_to edit_user_path(current_user)
		end
	end


end
