class AddEducationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :education, :string, :limit => 255
  end
end
