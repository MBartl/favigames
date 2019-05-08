Rails.application.routes.draw do

  resources :favorites
  resources :games
  resources :users
  resources :welcome

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  root 'welcome#home'
end
