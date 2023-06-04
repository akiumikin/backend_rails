class Types::ClientUser < Types::BaseObject
  field :id,   ID,          null: true, description: '企業ユーザーID'
  field :role, String,      null: true, description: '役割'
  field :user, Types::User, null: true, description: 'ユーザー'

  def user
    AssociationLoader.for(ClientUser, :user).load(object)
  end
end
