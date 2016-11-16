class UsersController < ApplicationController
	before_action :authenticate_user!
 	before_action :set_user, only: [:show, :destroy]
 	before_action :set_current, only: [:update_tags, :update_location, :update, :edit]


	ActsAsTaggableOn.delimiter = ','

	def index
		@user = current_user
	end
	
	def update_tags
		@usertags = @user.tag_list
		@mostused = ActsAsTaggableOn::Tag.most_used(16)
	end

	# GET /events/1/edit
  def edit

  end

  def show
  	respond_to do |format|
  			format.html
        format.js
    end
  end

	def update_location
	end

	def update
		if set_current == current_user
			respond_to do |format|
	      if @user.update(user_params)
	      	path = (@user.full_street_address.nil? || @user.full_street_address.empty?) ? location_users_path : root_path
	        if (@user.about.nil? || @user.about.empty?)
	        	format.html { redirect_to edit_user_path, notice: 'User was successfully updated.' }
	        	format.json { render :show, status: :ok, location: @user }
	        else
	        	format.html { redirect_to path, notice: 'User was successfully updated.' }
	        	format.json { render :show, status: :ok, location: @user }
	      	end
	      else
	        format.html { render :edit }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
  	end
	end

	def create
		
	end

	def destroy
		@subscriptions = Subscription.where(user_id: @user.id)
		
		#Delete Open ChatRoom
		@subscriptions.each do |sub|
			@room_id = sub.chat_room_id	
			@all_users_subs = Subscription.where(chat_room_id:@room_id)
			@all_users_subs.delete_all
		end

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

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :gender, :about, :tag_list, :full_street_address, :job, :picture, :avatar, :cached_tag_list, :local, :country, :languages, :birthday)
  end


end
