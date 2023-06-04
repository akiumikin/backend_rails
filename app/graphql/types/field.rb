class Types::Field < Types::BaseObject
  field :id,          ID,     null: true, description: 'リソースフィールドID'
  field :name,        String, null: true, description: 'リソースフィールド名'
  field :input_type,  String, null: true, description: '入力方法'
  field :order_index, String, null: true, description: '並び順'
end
