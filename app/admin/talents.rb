ActiveAdmin.register Talent do

permit_params :title, :description, :picture, :user_id, :category

index do
  column :title
  column :user
  column :category
  column :contacted_times
  column :created_at
  actions
end

form :html => { :multipart => true } do |f|
  f.semantic_errors
  f.inputs do
    f.input :title
    f.input :description, as: :quill_editor
    f.input :picture
    f.input :category
    f.input :user, :collection => User.all.map{|u| ["#{u.email}", u.id]}
  end
  f.actions
end

show do
  attributes_table do
    row :title
    row :description
    row :user
    row :contacted_times
    row :category
    row :photo do |talent|
      image_tag talent.picture.big, width: 50
    end
  end
end


end
