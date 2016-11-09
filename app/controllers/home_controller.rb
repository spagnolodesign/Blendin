class HomeController < ApplicationController
  before_action :auth_user
	before_filter :allow

	def index
		@tags = (params[:t].to_s.blank?) ? current_user.tag_list : params[:t].split(",")
		@users = User.near([current_user.latitude, current_user.longitude], 20)
									.tagged_with(@tags, :any => true)
									.where(local: !current_user.local)
									.where.not(id: current_user.id)
									.paginate(:page => params[:page]).uniq
		

		@tags = User.all.tag_counts_on(:tags).as_json(only: [:name]).to_json.html_safe
    @tag_list = User.tag_counts_on(:tags).order('count desc')
	end

  def auth_user
    redirect_to new_user_registration_url unless user_signed_in?
  end

  def allow
  	if (current_user.latitude.nil? || current_user.latitude.nil?)
  		redirect_to edit_user_path(current_user)
  	end
  end


end
