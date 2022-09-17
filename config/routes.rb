Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/auth/google_oauth2/callback', to: 'users#create'
  resource :users do
    get '/dashboard', to: "users#show"
    get '/discover', to: "discover#index"
  end
  
  namespace :api do
    namespace :v1 do
      resources :satellites, only: [:show]
      resources :messages, only: [:show]
    end
  end
end
