Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # List routes
  resources :lists

  # Quiz routes
  get '/quiz/:list_id/new', to: 'quiz#new', as: :new_quiz
  match '/quiz/:list_id', to: 'quiz#quiz', as: :start_quiz, via: [:get, :post]
end
