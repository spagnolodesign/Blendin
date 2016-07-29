class ChangeSubscritpionName < ActiveRecord::Migration[5.0]
  def change
	    rename_table :subscriptions, :approvals
  end
end
