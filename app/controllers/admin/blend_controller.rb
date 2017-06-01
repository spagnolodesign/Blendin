class Admin::BlendController < Admin::AdminController

	def index

		@blend_grid = BlendGrid.new(params[:blend_grid]) do |scope|
	      scope.page(params[:page])
	  end

		respond_to do |format|
			format.html
		end
	end

end
