class Admin::AccountController < Admin::AdminController

	def index
		@users_grid = UsersGrid.new(params[:users_grid]) do |scope|
	      scope.page(params[:page])
	    end
		
		@users_grid_excel = UsersGrid.new(params[:users_grid])

		respond_to do |format|
			format.html
			format.xlsx 
		end
	end


private 

	def user_params
		params.require(:user).permit(:username, :email)
	end

end
