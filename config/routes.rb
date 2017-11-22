Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'blends/create'

  namespace :admin do
   resources :users
   resources :blends
   root to: "users#index"
  end

  # config/routes.rb
  scope "(:locale)", locale: /en|nl/ do


    get '/wizard', to: 'wizard#index'
    get '/upload-photo', to: 'wizard#upload'

    devise_for :users

    resources :users, only: [:show, :update]

    resources :blends, only: [:create, :new, :index] do
      get '/accept', to: 'blends#accept'
      get '/reject', to: 'blends#reject'
    end

    root 'home#index'
  end
end
