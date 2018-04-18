class DashboardController < ApplicationController

  def index
		@users = User.match_with(current_user, 7, 10).page params[:page]
		if @users.length <= 10
			@users = User.match_with(current_user, 15, 20).page params[:page]
		end
	end



end
