class Admin::AdminController < ApplicationController
	before_action :require_admin

	layout 'admin'


  def require_admin
  	authenticate_user!
    unless current_user.admin?
      redirect_to root_path
    end
  end

end
