class AddColumnToSubscription < ActiveRecord::Migration[5.0]
  def change
  	add_column :subscriptions, :user_id, :integer
    add_column :subscriptions, :event_id, :integer
  end
end
