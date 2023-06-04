class Types::Resource < Types::BaseObject
  field :id,     ID,             null: true, description: 'リソースID'
  field :name,   String,         null: true, description: 'リソース名'
  field :client, Types::Client,  null: true, description: '企業'
  field :flow,   Types::Flow,    null: true, description: 'フロー'
  field :fields, [Types::Field], null: true, description: 'リソースの基本データのフィールド'
  field :items,  [Types::ResourceItem],  null: true, description: 'リソースのデータ内容'
  field :first_parent_resource,  Types::Resource, null: true, description: '親リソース1'
  field :second_parent_resource, Types::Resource, null: true, description: '親リソース2'

  def client
    AssociationLoader.for(Resource, :client).load(object)
  end

  def flow
    AssociationLoader.for(Resource, :flow).load(object)
  end

  def items
    AssociationLoader.for(Resource, :items).load(object)
  end

  def fields
    AssociationLoader.for(Resource, :fields).load(object)
  end

  def first_parent_resource
    AssociationLoader.for(Resource, :first_parent_resource).load(object)
  end

  def second_parent_resource
    AssociationLoader.for(Resource, :second_parent_resource).load(object)
  end
end
