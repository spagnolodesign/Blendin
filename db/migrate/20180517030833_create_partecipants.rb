class CreatePartecipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.references :user, foregin_key: true
      t.references :event, foregin_key: true
      t.timestamps
    end
  end
end
