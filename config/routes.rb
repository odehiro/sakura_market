Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  root 'home#index'
  get 'home/show'
  devise_for :users
  resources :users, :only => [:index, :show]
end
