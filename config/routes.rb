Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :books
  resources :users, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
