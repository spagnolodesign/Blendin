class UsersController < ApplicationController
	before_action :authenticate_user!
 	before_action :set_user, only: [:show, :destroy]
 	before_action :set_current, only: [:update_tags, :update_location, :update, :edit]


	def update_tags
		@usertags = @user.tag_list
		@mostused = User.tag_counts_on(:tags).limit(32)
	end

  def edit
  end

  def show
		@blend = current_user.blended?(@user)
		@newblend = Blend.new
  end

	def update_location
	end

	def update
		if set_current == current_user
			respond_to do |format|
	      if @user.update(user_params)
					if @user.avatar.present?
	        	format.html { redirect_to root_path, notice: 'All set up :)' }
					else
						format.html { redirect_to upload_photo_path, notice: 'Would be nice have a picture of you :)' }
					end
	      else
	        format.html { redirect_to wizard_path }
	      end
	    end
  	end
	end

	def create

	end

	def destroy
		#Delete User
		@user.destroy

		respond_to do |format|
      format.html { redirect_to :back, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
	end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :gender, :about, {:tag_list => []}, :full_street_address, :phone, :job, :picture, :avatar, :cached_tag_list, :local, :country, :languages, :birthday)
  end


end
