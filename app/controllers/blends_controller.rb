class BlendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipient, only: [:create]

  def create
    @blend = Blend.new(message: params[:message])
    @blend.sender = current_user
    @blend.recipient = @recipient

    if @blend.save

    else

    end
  end

  private

  def set_recipient
		@recipient = User.find(params[:user_id])
	end

  def blend_params
    params.require(:blends).permit(:message)
  end

end
