Rails.application.routes.draw do
  root to: 'homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorite_genres
      get :favorite_rooms
      get :favorite_messages
    end
    # 退会確認画面
    get 'confirm' => 'users#confirm', as: 'confirm'
    # 論理削除
    patch 'withdraw' => 'users#withdraw', as: 'withdraw'
  end

  resources :genres, only: [:index, :create, :show, :destroy] do
    resource :favorite_genres, only: [:create, :destroy]
    member do
      get :members
    end
  end

  resources :rooms, only: [:index, :create, :show, :destroy] do
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
      patch 'comments/:id/read' => 'comments#read', as: 'comment_read'
    end
  end
  
  resources :notifications, only: :index

  get 'search' => 'searches#search', as: 'search'
  
end
