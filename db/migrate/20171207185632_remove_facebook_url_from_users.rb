class RemoveFacebookUrlFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :facebook_picture_url, :string
  end
end
