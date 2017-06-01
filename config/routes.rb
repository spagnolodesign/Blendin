Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'sessions'}
  #match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]
  devise_scope :user do
    authenticated :user do
      root :to => 'home#index'
    end
    unauthenticated :user do
      root :to => 'registrations#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:show, :update, :edit, :destroy] do
    collection do
      get :tag, action: 'update_tags'
      get :location, action: 'update_location'
    end
    resources :knoks, only: [:like, :connect] do
      collection do
        get "like", to: "knok#like"
        get 'connect', to: "knok#connect"
      end
  	end
  end

  resources :availabilities, only: [:index, :add] do
    collection do
      get 'me', action: 'index'
      post "update", action: 'add'
    end
  end

  resources :chat_rooms, path: 'rooms', only: [:show, :index, :no_rooms, :destroy], param: :token

  root 'home#index'

  mount ActionCable.server => '/cable'

  ##ADMIN
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :account, only: [:index]
    resources :blend, only: [:index]
  end

end
