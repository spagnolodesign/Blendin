ActiveAdmin.register Network do
  permit_params :name, :sector, :network, :city, :email, :residence, :phone, :gender, :birthday, :about

  index do
    column :name
    column :email
    column :created_at
    actions
  end

end
