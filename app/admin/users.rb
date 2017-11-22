ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :username, :tag_list, :tags, :tag_ids, :cached_tag_list
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  scope :all, default: true

  index do
    column :username
    column :local
    column :phone
    actions
  end

  filter :username_contains, label: 'Full name'
  filter :email_contains, label: 'Email'
  filter :base_tags
  filter :local
  filter :created_at

  form :html => { :multipart => true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :username
      f.input :tag_list, :as => :select, :multiple => :true, :collection => ActsAsTaggableOn::Tag.pluck(:name)
    end
    f.actions
  end

end
