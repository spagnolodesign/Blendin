Rails.application.routes.draw do

  get 'blends/create'

  namespace :admin do
   resources :users
   resources :blends
   root to: "users#index"
  end

  get '/wizard', to: 'wizard#index'

  devise_for :users

  resources :users, only: [:show, :update]

  resources :blends, only: [:create, :new] do
    post '/accept', to: 'blends#accept'
    post '/reject', to: 'blends#reject'
  end

  root 'home#index'

end
