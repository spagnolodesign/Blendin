class AddToNetwork < ActiveRecord::Migration[5.1]
  def change
    add_column :networks, :birthday, :date
    add_column :networks, :gender, :string
    add_column :networks, :residence, :string
    add_column :networks, :about, :text
    add_column :networks, :phone, :string
  end
end
