Rails.application.routes.draw do

  resources :favorites
  resources :games
  resources :users, only: [:new, :create, :edit, :update, :index]
  resources :sessions, only: [:new, :create, :delete]

  root 'users#index'
end
