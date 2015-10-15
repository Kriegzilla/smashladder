Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :homes, only: :index
  resources :users, only: [:index, :show]
  resources :games, only: [:index, :show, :new, :create, :destroy] do
    get 'pending_games', on: :collection
    post 'approve'
  end
end
