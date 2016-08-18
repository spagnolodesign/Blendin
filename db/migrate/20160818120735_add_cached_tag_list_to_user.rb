class AddCachedTagListToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users,  :cached_tag_list, :string
    User.reset_column_information
    # next line makes ActsAsTaggableOn see the new column and create cache methods
    ActsAsTaggableOn::Taggable::Cache.included(User)
    User.find_each(:batch_size => 1000) do |p|
      p.tag_list # it seems you need to do this first to generate the list
      p.save!
    end    
  end
end
