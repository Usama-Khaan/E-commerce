Rails.application.routes.draw do
  root 'products#index'

  patch '/update_line_items', to: 'line_items#update_line_items'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  resources :users
  resources :products do
    collection do
      get :step2
    end
  end
  resources :carts, except: %i[index new] do
    member do
      get :add_product
      delete :remove_product
      delete :reset
    end
  end
  resources :orders, except: %i[edit] do
    member do
      get :complete
    end
  end
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index]
    end
  end
end
