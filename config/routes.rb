Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # List routes
  resources :lists

  # Quiz routes
  get '/quiz/:list_id/new', to: 'quiz#new', as: :new_quiz
  post '/quiz/:list_id', to: 'quiz#start', as: :start_quiz
end
