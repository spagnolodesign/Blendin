class AddLatLonAddressToUser < ActiveRecord::Migration[5.0]
	def change
    add_column :users, :full_street_address, :string
    add_column :users, :latitute, :float
    add_column :users, :longiture, :float
  end
end
