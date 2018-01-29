Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :bookmarks
      resources :tags, only: [:index]
    end
  end
end
