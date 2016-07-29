class DropChatRooms < ActiveRecord::Migration[5.0]
  def change
  	drop_table :chatrooms
  	drop_table :messages
  end
end
