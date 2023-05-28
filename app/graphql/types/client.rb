class Types::Client < Types::BaseObject
  field :id,     ID,                    null: true, description: '企業ID'
  field :name,   String,                null: true, description: '企業名'
  field :users,  [Types::User],         null: true, description: '所属ユーザー'
  field :config, [Types::ClientConfig], null: true, description: '企業設定'
end
