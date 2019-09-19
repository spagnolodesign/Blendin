class CreateTalents < ActiveRecord::Migration[5.1]
  def change
    create_table :talents do |t|
      t.string :title
      t.string :description
      t.references :user, foreign_key: true
      t.string :picture
      t.integer :contacted_times, default: 0
      t.timestamps
    end
  end
end
