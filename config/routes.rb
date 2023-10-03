Rails.application.routes.draw do
  get 'carts/index'
  root 'products#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }

  resources :users
  resources :products
end
