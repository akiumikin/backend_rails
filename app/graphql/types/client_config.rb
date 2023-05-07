class Types::ClientConfig < Types::BaseObject
  field :id,        ID,     null: true, description: '企業設定ID'
  field :client_id, ID,     null: true, description: '企業ID'
  field :kind,      String, null: true, description: '設定種別'
  field :value,     String, null: true, description: '設定値'
end
