Rails.application.routes.draw do

  resources :favorites
  resources :games
  resources :users, only: [:new, :create, :edit, :update, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]


  get '/update_song', to: 'user#update_song'
  get '/results', to: 'game#results'
  get '/light', to: 'application#light', as: 'light'
  get '/dark', to: 'application#night', as: 'dark'

  root 'users#index'
end
