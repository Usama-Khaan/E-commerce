Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }

  resources :users
  resources :products
end
