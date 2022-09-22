Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
 
  get '/auth/google_oauth2/callback', to: 'users#create'

  get '/satellite', to: 'satellites#show'

  resource :users do
    get '/dashboard', to: "users#show"
    get '/discover', to: "discover#index"
  end
  
  resources :messages, only: [:show, :new]

  post 'messages/create', to: 'messages#create'
end
