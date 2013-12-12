Ocular::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:index, :create, :destroy, :update] do
    resource :newsfeed, only: :show
    resource :profile, only: [:new, :create, :edit, :update, :show]
    resource :friendship, only: :create
  end
  resources :friendships, only: [:update, :destroy]
  resources :statuses, only: [:create, :edit, :update, :destroy]
  root to: "root#root"
end
