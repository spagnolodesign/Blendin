class ChatRooms < ActiveRecord::Migration[5.0]
  create_table :chatrooms do |t|
      t.string :topic
      t.string :slug
      t.timestamps
  end
end
