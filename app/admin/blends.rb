ActiveAdmin.register Blend do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  column :sender
  column :recipient
  column :status
  actions
end



form do |f|
  f.semantic_errors
  f.inputs do
    f.input :sender
    f.input :recipient
    f.input :message
    f.input :status, as: :select, collection:  Blend::STATES
  end
  f.actions
end

end
