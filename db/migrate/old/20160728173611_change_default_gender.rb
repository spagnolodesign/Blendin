class ChangeDefaultGender < ActiveRecord::Migration[5.0]
  def change
	    change_column_default :users, :gender, ""
  end
end
