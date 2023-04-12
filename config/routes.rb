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
  resources :books, only: [:new,:create,:index,:show,:destroy]
  resources :users, only: [:show,:index,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
