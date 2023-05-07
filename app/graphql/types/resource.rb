class Types::Resource < Types::BaseObject
  field :id,   ID,     null: true, description: 'リソースID'
  field :name, String, null: true, description: 'リソース名'
end
