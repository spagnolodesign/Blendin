class CreateNetworkApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :network_applications do |t|
      t.string :name
      t.text :sector
      t.text :network
      t.string :city
      t.string :email

      t.timestamps
    end
  end
end
