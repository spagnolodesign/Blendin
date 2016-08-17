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

  def show
    joined_rooms = current_user.subscriptions.pluck(:chat_room_id)
    @chat_rooms = ChatRoom.find(joined_rooms)
    @chat_room = ChatRoom.includes(:messages).find_by(token: params[:token])
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end