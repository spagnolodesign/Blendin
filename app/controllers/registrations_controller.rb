# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
	layout 'auth'

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :username, :local)
  end

end 