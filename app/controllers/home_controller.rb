class HomeController < ApplicationController

	def index
		if user_signed_in?
			@berries = (params[:berries].to_s.blank?) ? current_user.tag_list : params[:berries]
			@users = User.tagged_with(@berries, :any => true).where.not(id: current_user.id)
			if @users.empty?
				@users = User.all.where.not(id: current_user.id)
			end
			@tags = User.all.tag_counts_on(:tags).as_json(only: [:name]).to_json.html_safe
			
		else
			render "welcome"
		end
	end



end
