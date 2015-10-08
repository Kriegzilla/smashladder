Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :users, only: [:index, :show, :destroy]
  resources :games, only: [:index, :show, :new, :create] do
    get 'pending_games', on: :collection
    post 'approve'
  end
end
