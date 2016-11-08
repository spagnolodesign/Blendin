class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    # if !current_user.messages.empty?
    #   last_room = current_user.messages.last.chat_room
    #   redirect_to chat_room_path(last_room.token)
    # else
      if current_user.chat_rooms.empty?
        render :no_rooms
      else
        last_room_applied = current_user.chat_rooms.last
        redirect_to chat_room_path(last_room_applied.token)
      end
    # end
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = User.first.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def destroy
      @chat_room = ChatRoom.where(token: params[:token]).first
      @subscriptions = Subscription.where(chat_room_id: @chat_room.id)
      @chat_room.destroy
      @subscriptions.delete_all
      respond_to do |format|
          format.html { redirect_to chat_rooms_path, notice: 'Deleted.' }
      end
  end


  def show
    joined_rooms = current_user.subscriptions.pluck(:chat_room_id)
    @chat_rooms = ChatRoom.all.order('created_at DESC').find(joined_rooms)
    @chat_room = ChatRoom.where(token: params[:token]).first
    @messages = Message.where(chat_room_id: @chat_room).order('created_at DESC').paginate(:page => params[:page])
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end