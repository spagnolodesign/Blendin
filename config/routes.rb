Rails.application.routes.draw do

  get 'blends/create'

  namespace :admin do
   resources :users
   resources :blends
   root to: "users#index"
  end


  devise_for :users

  resources :users, only: [:show]
  resources :blends, only: [:create, :new] do
    post '/accept', to: 'blends#accept'
    post '/reject', to: 'blends#reject'
  end

  root 'home#index'

end
