class CreateUsersRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :users_rooms, id: false do |t|
      t.belongs_to :chat_rooms, index: true
      t.belongs_to :users, index: true
    end
  end
end
