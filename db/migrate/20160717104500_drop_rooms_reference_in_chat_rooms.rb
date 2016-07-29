class DropRoomsReferenceInChatRooms < ActiveRecord::Migration[5.0]
  def change
	  	remove_column :subscriptions, :chat_rooms_id
  end
end
