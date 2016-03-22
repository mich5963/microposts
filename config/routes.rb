Rails.application.routes.draw do

  root to: 'static_pages#home'
  
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #get 'logout', to: 'sessions#destroy'
  # get 'followings', to: 'users#followings'
  # get 'followers', to: 'users#followers'
  # post '/users/', to: 'users#create'    
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end

end
