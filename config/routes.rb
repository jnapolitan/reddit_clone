Rails.application.routes.draw do

  resources :users, except: [:edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :destroy

  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create]
end
