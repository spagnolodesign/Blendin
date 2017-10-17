class AddElementsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :languages, :string
    add_column :users, :birthday, :date
    add_column :users, :country, :string
  end
end
