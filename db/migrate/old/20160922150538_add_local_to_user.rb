class AddLocalToUser < ActiveRecord::Migration[5.0]
  def change
	    add_column :users, :local, :boolean, default: :false
  end
end
