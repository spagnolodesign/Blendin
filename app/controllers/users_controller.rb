class UsersController < ApplicationController
	before_action :authenticate_user!
 	before_action :set_user, only: [:show]
 	before_action :set_current, only: [:berry, :location, :update, :edit]


	ActsAsTaggableOn.delimiter = ' '

	def index
		@user = current_user
	end
	
	def berry
	end

	# GET /events/1/edit
  def edit
  end

	def location
	end

	def update
		if set_current == current_user
			respond_to do |format|
	      if @user.update(user_params)
	      	path = (@user.full_street_address.nil? || @user.full_street_address.empty?) ? location_user_path : root_path
	        format.html { redirect_to path, notice: 'User was successfully updated.' }
	        format.json { render :show, status: :ok, location: @user }
	      else
	        format.html { render :edit }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
  	end
	end

	def create
		byebug
	end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :gender, :about, :tag_list, :full_street_address)
  end


end
