Rails.application.routes.draw do
  root 'home#index'
  get 'home/show'
  devise_for :users
end
