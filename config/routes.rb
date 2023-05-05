Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "#{ActionController::Base.relative_url_root}/graphql"
  post "/graphql", to: "graphql#execute"

  get 'system_info', to: 'system#info'
end
