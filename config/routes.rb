Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :genres, only: [:index, :create, :show]
  resources :rooms, only: [:index, :create, :show]
  
end
