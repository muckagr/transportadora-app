Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  devise_for :admins
  root to: 'home#index'

  namespace :admin do
    resources :shipping_companies
    resources :orders
  end

  namespace :user do
    resources :shipping_companies, only: %i[show update edit] do
      resources :orders, only: %i[show update edit index]
      resources :vehicles, only: %i[index new create]
    end
  end
end
