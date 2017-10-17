class AddAddressToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :full_street_address, :string
  end
end
