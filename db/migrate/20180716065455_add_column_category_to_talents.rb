class AddColumnCategoryToTalents < ActiveRecord::Migration[5.1]
  def change
    add_column :talents, :category, :string
  end
end
