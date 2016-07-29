class AddRoomsIdToEvents < ActiveRecord::Migration[5.0]
  def change
			add_reference :events, :chat_rooms, index: true
  end
end
