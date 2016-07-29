class RemoveReferenceToEvents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :chat_rooms_id
  end
end
