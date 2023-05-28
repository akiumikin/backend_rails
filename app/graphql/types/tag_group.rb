class Types::TagGroup < Types::BaseObject
  field :id,   ID,     null: true, description: 'タググループID'
  field :name, String, null: true, description: 'タググループ名'
end
