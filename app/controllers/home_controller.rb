class HomeController < ApplicationController

	def index
		if user_signed_in?
			@berries = (params[:berries].to_s.blank?) ? current_user.tag_list : params[:berries]
			@users = User.tagged_with(@berries, :any => true).where.not(id: current_user.id)
		else
			render "welcome"
		end
	end



end
