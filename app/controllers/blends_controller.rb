class BlendsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @blend = Blend.new(blend_params)
    @blend.sender = current_user
    @blend.recipient = User.find(params[:recipient_id])

    if @blend.save
      redirect_to user_path(@blend.recipient)
    end

  end


  def accept
    @blend = Blend.find(params[:blend_id])
    @blend.update(status:'accepted')

    if @blend.save
      redirect_to user_path(@blend.recipient)
    end
  end

  def reject
    @blend = Blend.find(params[:blend_id])
    @blend.update(status:'rejected')

    if @blend.save
      redirect_to user_path(@blend.reciver)
    end
  end

  private


  def blend_params
    params.require(:blend).permit(:message)
  end

end
