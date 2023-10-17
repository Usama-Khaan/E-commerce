Rails.application.routes.draw do
  root 'products#index'

  patch '/update_line_items', to: 'line_items#update_line_items'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users
  resources :products
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
end
