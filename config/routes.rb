Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    session: 'users/sessions'
  }
end
