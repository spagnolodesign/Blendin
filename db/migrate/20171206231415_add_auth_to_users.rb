class AddAuthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :facebook_picture_url, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
