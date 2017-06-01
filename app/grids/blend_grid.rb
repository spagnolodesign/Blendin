class BlendGrid
  include Datagrid

  scope do
    Knok.all.order('created_at DESC')
  end

  column(:from_id, :header => "From", :mandatory => true) do |model|
    model.from.name
  end
  
  column(:to_id, :header => "TO", :mandatory => true) do |model|
    model.to.name
  end

end
