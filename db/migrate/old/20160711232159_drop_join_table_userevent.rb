class DropJoinTableUserevent < ActiveRecord::Migration[5.0]
  def change
  	  drop_join_table :users, :events 
  end
end
