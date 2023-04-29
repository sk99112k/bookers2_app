Rails.application.routes.draw do
  #get 'users/show'
  #get 'users/edit'
  #get 'books/new'
  #get 'books/index'
  #get 'books/show'
  #get 'homes/top'
  devise_for :users
  root to:"homes#top"
  get 'home/about' => 'homes#about'
  resources :books, only: [:new,:create,:index,:edit,:update,:show,:destroy] do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end
  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'daily_posts' => "users#daily_posts"
  end
  get 'search' => 'searches#search_list'

  devise_scope :user do
    post 'users/guest_sign_in', to:'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
