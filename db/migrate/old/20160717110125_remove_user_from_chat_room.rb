class RemoveUserFromChatRoom < ActiveRecord::Migration[5.0]
  def change
  	remove_column :chat_rooms, :user_id
  end
end
