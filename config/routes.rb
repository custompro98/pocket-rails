Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  scope :api do
    namespace :v1 do
      resources :bookmarks do
        resources :tags, only: [:index, :create, :destroy]
      end
      resources :tags, only: [:index, :create, :destroy]

      post "/graphql", to: "graphql#execute"
      mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/api/v1/graphql' unless Rails.env.production?
    end
  end
end
