Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # config/routes.rb
  scope "(:locale)", locale: /en|nl/ do
    root 'home#index'
    get '/wizard', to: 'wizard#index'
    get '/upload-photo', to: 'wizard#upload'
    get 'blends/create'

    devise_for :users, skip: :omniauth_callbacks

    resources :users, only: [:show, :update]

    resources :blends, only: [:create, :new, :index] do
      get '/accept', to: 'blends#accept'
      get '/reject', to: 'blends#reject'
    end
  end

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}



end
