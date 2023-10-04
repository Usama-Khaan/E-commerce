Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }

  resources :users
  resources :products
  resources :carts, only: [:show, :destroy] do
    post 'add/:product_id', to: 'carts#add_to_cart', on: :member, as: 'add_product'
    delete 'remove/:product_id', to: 'carts#remove_from_cart', on: :member, as: 'remove_product'
  end
end
