Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :users, only: :index
  resources :games, only: [:index, :new, :create]
end
