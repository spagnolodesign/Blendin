class AddFieldToNetwork < ActiveRecord::Migration[5.1]
  def change
    add_column :networks, :experience, :integer
    add_column :networks, :reference, :string

  end
end
