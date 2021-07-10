Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
  }

  devise_scope :user do
    post 'users/guest', :to => 'users/sessions#guest'
  end

  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get :following, on: :member
    get :followers, on: :member
    resource :relationships, only: [:create, :destroy]

  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
    get :bookmarks, on: :collection
    get :post_search, on: :collection
  end

  resources :tags do
    get 'posts', to: 'posts#search'
  end

end
