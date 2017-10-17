class RenameTableUser < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users, :latitute, :latitude
  	rename_column :users, :longiture, :longitude
  end
end
