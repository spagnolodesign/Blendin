ActiveAdmin.register Event do

  permit_params :date, :time, :name, :description, :city, :address, :zip_code, :max_refugee_capacity, :max_local_capacity, :photo, :community_events, :topic

  scope :all

  index do
    column :photo do |event|
      image_tag event.photo.small_event, width: 50
    end
    column :name
    column :date
    column :created_at
    column "participants" do |event|
      event.participants.count
    end
    actions
  end

  form :html => { :multipart => true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :topic
      f.input :name
      f.input :date, as: :datepicker
      f.input :time
      f.input :address
      f.input :city
      f.input :zip_code
      f.input :max_refugee_capacity
      f.input :max_local_capacity
      f.input :photo
      f.input :community_events
      f.input :description, as: :quill_editor
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
    end

    panel "Local participants" do
       attributes_table_for event.local_participants do
         row :username
       end
    end

    panel "New comer participants" do
       attributes_table_for event.refugee_participants do
         row :username
       end
    end
   end


end
