class AddTintToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :tint, :string
  end
end
