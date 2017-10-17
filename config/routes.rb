Rails.application.routes.draw do

  get 'blends/create'

  namespace :admin do
   resources :users
   root to: "users#index"
  end


  devise_for :users

  resources :users, only: [:show]
  resources :blends, only: [:create, :new]

  root 'home#index'

end
