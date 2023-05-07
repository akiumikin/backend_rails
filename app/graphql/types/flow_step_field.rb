class Types::FlowStepField < Types::BaseObject
  field :id,           ID,      null: true, description: 'ステップ入力項目ID'
  field :flow_step_id, String,  null: true, description: 'ステップID'
  field :order_index,  Integer, null: true, description: '並び順'
  field :input_type,   String,  null: true, description: 'フォーム種別'
  field :name,         String,  null: true, description: '入力項目名'
end
