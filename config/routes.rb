Rails.application.routes.draw do
  root "sessions#home"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  
 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 delete '/logout' => 'sessions#destroy'

 get "/auth/:provider/callback" => 'sessions#google'
 #get "/auth/google_oauth2/callback", to: "sessions#google_oauth"
 
  resources :comments
  resources :poems do
    resources :comments #, only: [:new, :create, :index]
  end
  resources :users 
  resources :poems #, only: [:new, :create, :index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
