Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :users, only: [:index, :show]

  # as :user do
  #   get     "signup", to: "devise/registrations#new"
  #   post    "signup", to: "devise/registrations#create"
  #   get     "signin", to: "devise/sessions#new"
  #   post    "signin", to: "devise/sessions#create"
  #   delete  "signout", to: "devise/sessions#destroy"
  # end
end
