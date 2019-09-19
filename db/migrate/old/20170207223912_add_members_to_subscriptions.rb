class AddMembersToSubscriptions < ActiveRecord::Migration[5.0]
  def change
  	add_column :subscriptions, :members, :text, array:true, default: []
  end
end
