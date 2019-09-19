class UserKnock < ActiveRecord::Migration[5.0]
  def change
  	create_table :knoks do |t|
      t.integer :from_id, index: true
      t.integer :to_id, index: true
      t.boolean :liked
      t.timestamps
  end
  end
end
