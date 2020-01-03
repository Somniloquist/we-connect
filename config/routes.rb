Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :friendships, only: [:create, :destroy, :update]
  resources :likes, only: [:create, :destroy]

  resources :posts do
    resources :comments, only: [:new, :create, :delete]
    member do
      get :likes
    end
  end

  resources :users, only: [:index, :show] do
    member do
      get :friends
    end
  end

  resources :comments, only: [:new, :create, :delete] do
    resources :comments, only: [:new, :create, :delete]
  end
end
