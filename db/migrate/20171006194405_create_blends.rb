class CreateBlends < ActiveRecord::Migration[5.0]
  def change
    create_table :blends do |t|
      t.references :sender
      t.references :recipient
      t.text :message
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
