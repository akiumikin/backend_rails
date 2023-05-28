class Types::FlowStep < Types::BaseObject
  field :id,          ID,                     null: true, description: 'ステップID'
  field :flow_id,     String,                 null: true, description: 'フロー名'
  field :order_index, Integer,                null: true, description: '並び順'
  field :status,      String,                 null: true, description: 'ステップ管理ステータス'
  field :name,        String,                 null: true, description: 'ステップ名'
  field :fields,      [Types::FlowStepField], null: true, description: '入力項目'
end
