Ocular::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:index, :create, :destroy, :update] do
    collection do
      get "requests"
    end
    resource :newsfeed, only: :show
    resource :profile, only: [:new, :create, :edit, :update, :show]
    resource :friendship, only: :create
  end
  resources :friendships, only: [:update, :destroy]
  resources :statuses, only: [:create, :edit, :update, :destroy]
  resources :comments, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]
  root to: "root#root"
end