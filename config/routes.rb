Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  root 'home#index'
  get 'home/show'
  devise_for :users
  resources :users
  resources :foods do
    member { get :image }
  end
end
