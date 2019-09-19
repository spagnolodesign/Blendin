class BlendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_blends = Blend.where("sender_id = ? OR recipient_id = ?", "#{current_user.id}", "#{current_user.id}").order(created_at: :desc)
  end

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

    if @blend.update(status:'accepted')
      redirect_to user_path(@blend.sender)
    end
  end

  def reject
    @blend = Blend.find(params[:blend_id])

    if @blend.update(status:'declined')
      redirect_to user_path(@blend.sender)
    end
  end

  private


  def blend_params
    params.require(:blend).permit(:message)
  end

end
