class Types::UserProfile < Types::BaseObject
  field :id,           ID,     null: true, description: 'プロフィールID'
  field :user_id,      ID,     null: true, description: 'ユーザーID'
  field :first_name,   String, null: true, description: '名'
  field :last_name,    String, null: true, description: '姓'
  field :email,        String, null: true, description: 'メールアドレス'
  field :phone_number, String, null: true, description: '電話番号'
end
