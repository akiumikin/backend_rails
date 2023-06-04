module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    PAGE_LIMIT = 100

    # ------------------------------------------------

    field :connection_test, String, null: true, description: '接続確認'
    def connection_test
      'OK'
    end

    # ------------------------------------------------

    field :client, Types::Client, null: true, description: '企業' do
      argument :id,         ID,     required: true
      argument :cognito_id, String, required: true
    end

    def client(**args)
      client_id = client_id(args[:id], args[:cognito_id])
      ::Client.find(client_id)
    end

    # ------------------------------------------------

    field :current_user, Types::User, null: true, description: 'ログインユーザー' do
      argument :cognito_id, String, required: true
    end

    def current_user(**args)
      ::User.find_by!(cognito_id: args[:cognito_id])
    end

    # ------------------------------------------------

    field :client_users, Types::ClientUserIndex, null: true, description: 'ユーザー' do
      argument :client_id,  ID,     required: true
      argument :cognito_id, String, required: true
      argument :page,       Integer, required: false
      argument :limit,      Integer, required: false
    end

    def client_users(page: 1, limit: 25, **args)
      client_id = client_id(args[:client_id], args[:cognito_id])
      raise GraphQL::ExecutionError, "件数の最大値は#{PAGE_LIMIT}件です" if limit > PAGE_LIMIT

      params = { page:, limit:, args: }
      client_users = ::ClientUser.where(client_id: args[:client_id])

      { params:, data: client_users }
    end

    # ------------------------------------------------

    field :flows, Types::FlowIndex, null: true, description: 'フロー' do
      argument :client_id,  ID,     required: true
      argument :cognito_id, String, required: true
      argument :page,       Integer, required: false
      argument :limit,      Integer, required: false
    end

    def flows(page: 1, limit: 25, **args)
      client_id = client_id(args[:client_id], args[:cognito_id])
      raise GraphQL::ExecutionError, "件数の最大値は#{PAGE_LIMIT}件です" if limit > PAGE_LIMIT

      params = { page:, limit:, args: }

      { params:, data: ::Flow.where(client_id:) }
    end

    # ------------------------------------------------

    field :tag_groups, Types::TagGroupIndex, null: true, description: 'タグ' do
      argument :client_id,  ID,     required: true
      argument :cognito_id, String, required: true
      argument :page,       Integer, required: false
      argument :limit,      Integer, required: false
    end

    def tag_groups(page: 1, limit: 25, **args)
      client_id = client_id(args[:client_id], args[:cognito_id])
      raise GraphQL::ExecutionError, "件数の最大値は#{PAGE_LIMIT}件です" if limit > PAGE_LIMIT

      params = { page:, limit:, args: }

      { params:, data: ::TagGroup.where(client_id:) }
    end

    # ------------------------------------------------

    field :resources, Types::ResourceIndex, null: true, description: 'リソース' do
      argument :client_id,   ID,     required: true
      argument :cognito_id,  String, required: true
      argument :resource_id, Integer, required: false
      argument :page,        Integer, required: false
      argument :limit,       Integer, required: false
    end

    def resources(page: 1, limit: 25, **args)
      client_id = client_id(args[:client_id], args[:cognito_id])
      raise GraphQL::ExecutionError, "件数の最大値は#{PAGE_LIMIT}件です" if limit > PAGE_LIMIT

      params = { page:, limit:, args: }

      resources = ::Resource.where(client_id:)
      resources = resources.where(id: args[:resource_id]) if args[:resource_id].present?

      { params:, data: resources }
    end

    # ------------------------------------------------

    private

    def client_id(client_id, cognito_id)
      user_id = ::User.find_by!(cognito_id: cognito_id).id
      return ::ClientUser.find_by!(user_id: user_id).id if client_id.to_i.zero?

      client_ids = ::ClientUser.where(user_id: user_id).pluck(:client_id)
      raise GraphQL::ExecutionError, '所属していない企業へのアクセスです。' unless client_ids.include?(client_id.to_i)
      client_id
    end

  end
end
