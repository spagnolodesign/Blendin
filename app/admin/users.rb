ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :username, {:tag_list => []}, :cached_tag_list, :phone, :local, :birthday, :job, :full_street_address, :longitude, :latitude

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  scope :all
  # scope :full_street_address_contains do |users|
  #   byebug
  #   User.all.near_address('Amsterdam')
  # end

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
  filter :avatar_present, :as => :boolean , label: 'Avatar'
  filter :gender, :as => :select , label: 'Gender'
  filter :full_street_address, :as => :select


  form :html => { :multipart => true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :username
      f.input :phone
      f.input :local
      f.input :birthday, as: :datepicker
      f.input :job
      f.input :full_street_address
      f.input :tag_list, :as => :select, :multiple => :true, :collection => ActsAsTaggableOn::Tag.pluck(:name)
    end
    f.actions
  end

  show do
    attributes_table do
      row :username
      row :local
      row :avatar do |user|
        image_tag user.avatar.medium_avatar
      end
      row :job
      row :about
      row :full_street_address
      row :country
      row :birthday
      row :gender
      list_row :tag_list, list_type: :ol
      row :phone
      row :education
      row :languages
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
    end
    # renders app/views/admin/users/_matches.html.erb
    render 'matches', { user: user }
   end

end
