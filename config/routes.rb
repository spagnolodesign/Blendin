Rails.application.routes.draw do
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
  #match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]

  resources :users, only: [:show, :update, :edit] do
    member do
      get "berries", to: "users#berry"
      get "location", to: "users#location", path: 'get-location'
    end 
  end

  resources :chat_rooms, path: 'rooms', only: [:show, :index], param: :token

  resources :knoks, only: [:like, :dislike] do
	    member do
	        put "like", to: "knok#like"
	        put "dislike", to: "knok#dislike"
	    end
	end

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "home#index"
  #mount ActionCable.server => '/cable'

end
