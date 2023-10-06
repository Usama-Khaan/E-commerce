Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }

  resources :users
  resources :products
  resources :carts, except: %i[index new] do
    get 'add_product/:id', to: 'carts#add_product', as: 'add_product'
    delete 'remove_product/:id', to: 'carts#remove_product', as: 'remove_product'
    delete 'clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
  end
end
