class AddRoomsIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
  	add_column :subscriptions, :chat_rooms_id, :integer
  end
end
