# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    @message = current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
    @message.mark_as_read! :for => current_user
  end

  def send_typing(data)
  	ActionCable.server.broadcast "chat_rooms_#{data['chat_room_id']}_channel", message: "IM typing", action: "TYPING"
  end

end
