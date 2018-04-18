Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # config/routes.rb
  scope "(:locale)", locale: /en|nl/ do
    # root 'home#index'
    root 'dashboard#index'
    get '/all_blends', to: 'home#index', as: 'home'
    get '/wizard', to: 'wizard#index'
    get '/upload-photo', to: 'wizard#upload'
    get 'blends/create'
    get '/dashboard', to: 'dashboard#index'
    devise_for :users, skip: :omniauth_callbacks

    resources :users, only: [:show, :update]

    resources :blends, only: [:create, :new, :index] do
      get '/accept', to: 'blends#accept'
      get '/reject', to: 'blends#reject'
    end

    resources :networks, only: [:new, :create, :index], :path => "work"
  end

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  # Sidekiq Web UI, only for admins.
  # require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end



end
