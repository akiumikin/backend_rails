class Types::Flow < Types::BaseObject
  field :id,    ID,                null: true, description: 'フローID'
  field :name,  String,            null: true, description: 'フロー名'
  field :steps, [Types::FlowStep], null: true, description: 'ステップ'
end
