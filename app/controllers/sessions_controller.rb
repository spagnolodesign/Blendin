class SessionsController < Devise::SessionsController
  
	layout 'auth', only: [:new]

	# POST /resource/sign_in
  def create
    super
    flash.delete(:notice)
  end

  # DELETE /resource/sign_out
  def destroy
    super
    flash.delete(:notice)
  end


end
