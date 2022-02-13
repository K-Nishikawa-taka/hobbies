Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :genres, only: [:index, :create, :show]
  resources :rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create, :show, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end

end
