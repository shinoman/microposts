Rails.application.routes.draw do
  get 'users/edit'

  get 'sessions/new'

  root to: 'static_pages#home'
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users
  resources :users do
    member do
      get "followings"
      get "followers"
      get "microposts_post"
      get "followers"
      get "followings"
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
