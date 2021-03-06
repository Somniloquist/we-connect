Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :friendships, only: [:create, :destroy, :update]
  resources :likes, only: [:create, :destroy]
 

  resources :posts do
    resources :comments, only: [:new, :create, :delete]
    member do
      get :likes
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    get "settings", to: "users#edit"
    patch "settings", to: "users#update"
    member do
      delete "/delete_banner", to: "users#delete_banner_picture"
      delete :delete_avatar
      get :friends
    end
  end

  resources :comments, only: [] do
    get :toggle_form, on: :member
    resources :comments, only: [:new, :create, :delete]
  end
end
