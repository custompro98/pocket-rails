Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :bookmarks do
        resources :tags, only: [:index, :create, :destroy]
      end
      resources :tags, only: [:index, :create, :destroy]
    end
  end
end
