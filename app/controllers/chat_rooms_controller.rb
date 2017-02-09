class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index  
    if params[:user]
      user_to_chat_with = User.find(params[:user]) 
      token = generate_subscription(current_user, user_to_chat_with)
      @chat_rooms = current_user.chat_rooms
      redirect_to chat_room_path(token)
    else
      subscription = Subscription.where("members @> ?::text[]", '{'"#{current_user.id}"'}').last
      token = ChatRoom.find(subscription.chat_room_id).token
      redirect_to chat_room_path(token)
    end
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    # @chat_room = User.first.chat_rooms.build(chat_room_params)
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
    @subscriptions = Subscription.where("members @> ?::text[]", '{'"#{current_user.id}"'}')
    @chat_room = ChatRoom.where(token: params[:token]).first
    @messages = Message.where(chat_room_id: @chat_room).order('created_at DESC').paginate(:page => params[:page])
        
    #New message for form
    @message = Message.new

    #Mark all messages as read!
    Message.mark_as_read! :all, :for => current_user
  end

  private

  def generate_subscription(a, b) 

    old_subscription = Subscription.where("members @> ?::text[]", '{'"#{a.id},#{b.id}"'}').first
    
    if !old_subscription.nil? 
      token = ChatRoom.find(old_subscription.chat_room_id).token
      return token
    else
      subscribe_users(a, b)
    end
    #Subscription.where("members @> ?", '{33,35}')

  end

  def subscribe_users(user_one, user_two)
    new_chat_room_token = ChatRoom.create
    new_chat_room_token.save
    Subscription.create! chat_room_id: new_chat_room_token.id, members: [user_one.id,user_two.id].to_a
    return new_chat_room_token.token
  end

#Subscription.where("members @> ?", '{35}')

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end