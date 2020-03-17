Rails.application.routes.draw do
  root "sessions#home"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  
 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 delete '/logout' => 'sessions#destroy'
  resources :comments
  resources :poems do
    resources :comments #, only: [:new, :create, :index]
  end
  resources :users do
    resources :poems #, only: [:new, :create, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
