Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }

  resources :users
  resources :products
  resources :carts, except: %i[index new] do
    member do
      get 'add_product'
      delete 'remove_product'
      delete 'reset'
    end
  end
end
