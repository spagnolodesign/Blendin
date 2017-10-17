class BlendsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @blend = Blend.new(blend_params)
    @blend.sender = current_user
    @blend.recipient = User.find(params[:recipient_id])

    if @blend.save
      flash[:notice] = 'Successfully checked in'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to user_path(@blend.recipient)
  end

  private


  def blend_params
    params.require(:blend).permit(:message)
  end

end
