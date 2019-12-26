Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :friendships, only: [:create, :destroy, :update]
  resources :posts
  resources :users, only: [:index, :show] do
    member do
      get :friends
      get :posts
    end
  end
end
