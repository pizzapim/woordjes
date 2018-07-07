Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # List routes
  resources :lists
end
