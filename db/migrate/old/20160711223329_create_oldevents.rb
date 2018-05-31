class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.datetime :start

      t.timestamps
    end
  end
end
