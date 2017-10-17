Rails.application.routes.draw do

  get 'blends/create'

  namespace :admin do
   resources :users
   root to: "users#index"
  end


  devise_for :users

  resources :users, only: [:show] do
    resources :blends, only: [:create]
  end

  root 'home#index'

end
