Rails.application.routes.draw do
  root "sessions#home"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  
 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 delete '/logout' => 'sessions#destroy'

 get "/auth/:provider/callback" => 'sessions#google_auth'
 #get "/auth/google_oauth2/callback", to: "sessions#google_oauth"
 
  resources :comments
  resources :poems do
    resources :comments 
  end
  resources :users 
  resources :poems 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
