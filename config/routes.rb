Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # List routes
  resources :lists

  # Quiz routes
  get '/quiz/:list_id/new', to: 'quiz#new', as: :new_quiz
  match '/quiz/:list_id', to: 'quiz#quiz', as: :start_quiz, via: [:get, :post]
  post '/lists/:list_id/quiz_results', to: 'quiz_results#create', as: :create_quiz_result
  get '/lists/:list_id/quiz_results/:quiz_result_id', to: 'quiz_results#show', as: :quiz_result
end
