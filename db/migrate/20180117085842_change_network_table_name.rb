class ChangeNetworkTableName < ActiveRecord::Migration[5.1]
  def change
    rename_table :network_applications, :networks
  end
end
