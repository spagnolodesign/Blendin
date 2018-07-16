Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # config/routes.rb
  scope "(:locale)", locale: /en|nl/ do

    root 'dashboard#index'
    get "/dashboard", to: "dashboard#index"
    get "/pages/:page", to: "pages#show", as: :pages

    resources :events, only: [:index, :show] do
      resources :participants, only: [:create]
    end

    delete "/participants/:id", to: "participants#destroy"

    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]

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
        get "all", to: 'talents#all'
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
