module Admin
  class UsersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      super
      @resources = User.page(params[:page]).per(50)
    end

    def show
      user = User.find(params[:id])
      @mightmatch = User.all.near([user.latitude, user.longitude], 7).where(local: !user.local).tagged_with(user.tags, :any => true)
      if @mightmatch.any?
        @mightmatch.for_age_range(user.age - 2, user.age + 2)
      end
      super
    end

    def suggest
      byebug

    end
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
