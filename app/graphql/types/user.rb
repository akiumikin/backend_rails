class Types::User < Types::BaseObject
  field :id,      ID,                 null: true,  description: 'ユーザーID'
  field :profile, Types::UserProfile, null: true,  description: 'プロフィール'
  field :clients, [Types::Client],    null: false, description: '所属企業'

  def profile
    AssociationLoader.for(User, :profile).load(object)
  end

  def client
    AssociationLoader.for(User, :client).load(object)
  end
end
