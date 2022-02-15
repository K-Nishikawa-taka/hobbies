Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorite_genres
      get :favorite_rooms
      get :favorite_messages
    end
  end

  resources :genres, only: [:index, :create, :show] do
    resource :favorite_genres, only: [:create, :destroy]
    member do
      get :members
    end
  end

  resources :rooms, only: [:index, :create, :show] do
    resource :favorite_rooms, only: [:create, :destroy]
    member do
      get :members
    end
    resources :messages, only: [:create, :show, :destroy] do
      resource :favorite_messages, only: [:create, :destroy]
      member do
        get :favorite_users
      end
      resources :comments, only: [:create, :destroy]
    end
  end

end
