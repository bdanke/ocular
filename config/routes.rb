Ocular::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:index, :create, :destroy, :update] do
    collection do
      get "requests"
    end
    member do
      get "friends"
    end
    resources :albums, only: [:index, :show, :destroy]
    resources :photos, only: [:index, :edit, :update, :destroy, :show] do
      resources :tags, only: :create
    end
    resource :newsfeed, only: :show
    resource :profile, only: [:new, :create, :edit, :update, :show]
    resource :friendship, only: :create
    resources :message_threads, only: [:index, :show]
  end
  resources :messages, only: [:new, :create]
  resources :photos, only: :create
  resources :friendships, only: [:update, :destroy]
  resources :albums, only: [:new, :create]
  resources :statuses, only: [:create, :edit, :update, :destroy]
  resources :comments, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]
  resources :tags, only: :destroy
  root to: "root#root"
end