Rails.application.routes.draw do

  namespace :admin do
   resources :users
   resources :knoks

   root to: "users#index"
 end


  devise_for :users

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

  root 'home#index'

end
