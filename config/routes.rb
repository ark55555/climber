Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
  }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
    post 'users/guest', :to => 'users/sessions#guest'
  end

  root to: 'homes#top'
  resources :users, only: [:show,:edit,:update] do
    get :bookmark, on: :member
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'

  end
  get 'users/confirm' => 'users#confirm'
  patch 'users/retire' => 'users#retire'


  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

end
