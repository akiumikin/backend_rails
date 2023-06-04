class Types::ResourceStepItem < Types::BaseObject
  field :id,          ID,             null: true, description: 'ステップアイテムID'
  field :order_index, Integer,        null: true, description: 'ステータス'
  field :values,      [Types::Value], null: true, description: 'ステップの記入項目の値'

  def values
    AssociationLoader.for(Resource::Step::Item, :values).load(object)
  end

end
