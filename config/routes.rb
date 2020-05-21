Rails.application.routes.draw do

  root "static_pages#home"
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  resources :questions
  resources :question_similar_words
end
