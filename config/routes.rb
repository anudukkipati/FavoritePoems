Rails.application.routes.draw do
  root "sessions#home"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  
 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 
  resources :comments
  resources :poems
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
