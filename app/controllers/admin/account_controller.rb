class Admin::AccountController < Admin::AdminController

	def index
		@users_grid = UsersGrid.new(params[:users_grid]) do |scope|
      scope.page(params[:page])
    end
	end

end
