class AvailabilitiesController < ApplicationController
	
	def index
		@availabilities = current_user.available_list.to_json.html_safe
	end

	def add
		current_user.available.delete_all
		current_user.save

		user_schedule = params[:schedule]
		current_user.available_list.add(user_schedule, parse: true)

		# user = User.order("RANDOM()").first
		# user.available_list.add(user_schedule, parse: true)
		# user.save
		

		if current_user.save
			respond_to do |format|
			  format.html
	      format.json { render json: current_user.id }
	    end
  	end
	end

	def remove
		current_user.available_list.remove("MON 10-30/11-30")
		current_user.save
	end


end
