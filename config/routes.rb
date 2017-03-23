Rails.application.routes.draw do
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'sessions'}
  #match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]

  resources :users, only: [:show, :update, :edit, :destroy] do
    collection do
      get :tag, action: 'update_tags'
      get :location, action: 'update_location' 
    end
  end
  
  resources :availabilities, only: [:index, :add] do
    collection do
        get 'me', action: 'index' 
        post "update", action: 'add'
    end
  end

  resources :chat_rooms, path: 'rooms', only: [:show, :index, :no_rooms, :destroy], param: :token

  resources :knoks, only: [:like] do
	    member do
	        get "like", to: "knok#like"
	    end
	end

  root 'home#index'

  mount ActionCable.server => '/cable'

  ##ADMIN
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :account, only: [:index]
  end

end
