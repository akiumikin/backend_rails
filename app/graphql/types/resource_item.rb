class Types::ResourceItem < Types::BaseObject
  field :id,     ID,             null: true, description: 'アイテムID'
  field :status, String,         null: true, description: 'ステータス'
  field :values, [Types::Value], null: true, description: '基本情報の値'
  field :steps,  [Types::ResourceStepItem], null: true, description: 'ステップ'

  def values
    AssociationLoader.for(Resource::Item, :values).load(object)
  end

  def steps
    AssociationLoader.for(Resource::Item, :steps).load(object)
  end

end
