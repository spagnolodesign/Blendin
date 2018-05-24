Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # config/routes.rb
  scope "(:locale)", locale: /en|nl/ do

    root 'dashboard#index'
    get "/pages/:page" => "pages#show"

    #EVENTS
    resources :events do
      resources :partecipants, only: [:create]
    end
    delete "/partecipants/:id", to: "partecipants#destroy"


    # get '/all-blends', to: 'home#index', as: 'home'
    # get '/wizard', to: 'wizard#index'
    # get '/upload-photo', to: 'wizard#upload'
    # get 'blends/create'

    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]

    # resources :blends, only: [:create, :new, :index] do
    #   get '/accept', to: 'blends#accept'
    #   get '/reject', to: 'blends#reject'
    # end

    get "/settings/profile" => "settings#profile"
    get "/settings/photo" => "settings#photo"
    get "/settings/community" => "settings#community"

    resources :inbox, only: [:index, :show] do
      member do
         post "reply"
      end
    end

    resources :talents, only: [:index, :new] do
      collection do
        get "learn", to: 'talents#learn'
      end
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
