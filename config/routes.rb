Rails.application.routes.draw do

  resources :users, except: [:edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :destroy
  
end
