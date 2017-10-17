class DropTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :messages 
    drop_table :subscriptions
    drop_table :chat_rooms
    drop_table :events
    drop_table :knoks
    drop_table :read_marks
  end
end
