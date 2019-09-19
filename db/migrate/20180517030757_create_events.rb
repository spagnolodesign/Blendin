class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    drop_table :events
    create_table :events do |t|
      t.date :date
      t.time :time
      t.string :name
      t.text :description
      t.string :city
      t.string :topic, default: nil
      t.string :address
      t.integer :zip_code
      t.float :latitude
      t.float :longitude
      t.integer :max_refugee_capacity
      t.integer :max_local_capacity
      t.string :photo
      t.boolean :community_events, default: false
      t.timestamps
    end
  end
end
