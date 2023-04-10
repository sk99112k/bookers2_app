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
  resources :books, only: [:create,:index,:show]
  resources :users, only: [:show,:edit,:up]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
