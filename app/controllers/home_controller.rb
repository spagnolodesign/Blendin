class HomeController < ApplicationController
	before_action :authenticate_user!
	before_filter :allow

	def index
		#@tags = User.all.tag_counts_on(:tags).as_json(only: [:name]).to_json.html_safe
		@users = User
							.near([current_user.latitude, current_user.longitude], 20)
							.where(local: !current_user.local)
							.for_age_range(current_user.age - 2, current_user.age + 2)
							.tagged_with(current_user.tags, :any => true)
							.where.not(id: current_user.id).order("RANDOM()").last(10)
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
