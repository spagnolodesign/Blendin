# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    before_filter :default_params

    def authenticate_admin
      if current_user
        redirect_to '/', alert: 'Not authorized.' unless current_user.admin?
      else
        redirect_to '/', alert: 'You should sing in before access to the adminstration.'
      end
    end

    def default_params
      params[:order] ||= "created_at"
      params[:direction] ||= "desc"
    end
    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
