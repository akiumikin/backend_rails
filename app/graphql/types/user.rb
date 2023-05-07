class Types::User < Types::BaseObject
  field :id,      ID,                 null: true, description: 'ユーザーID'
  field :profile, Types::UserProfile, null: true, description: 'プロフィール'
end
