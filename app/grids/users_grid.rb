class UsersGrid
  include Datagrid

  #
  # Scope
  #
  scope do
    User
  end

  #
  # Filters
  #
  
  filter(:email, :string)
  filter(:local, :xboolean)

  #
  # Columns
  #

  column(:email, :mandatory => true) do |model|
    format(model.email) do |value|
      link_to value, "mailto:#{value}"
    end
  end
  
  column(:name, :header => "Name", :mandatory => true) do |model|
    model.name
  end

  column(:phone, :header => "Phone", :mandatory => true) do |model|
    model.phone
  end

  column(:full_street_address, :header => "Address", :mandatory => true) do |model|
    model.full_street_address
  end

  column(:gender, :header => "Gender", :mandatory => true) do |model|
    model.gender
  end

  column(:job, :header => "Job", :mandatory => true) do |model|
    model.job
  end
  
  column(:actions, :html => true, :mandatory => true) do |record|
    link_to "Delete", record, method: :delete, data: { confirm: 'Are you sure?' }
  end

end