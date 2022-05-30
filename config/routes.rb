Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  devise_for :admins
  root to: 'home#index'

  resources :home, only: %i[search] do
    get 'search', on: :collection
  end

  namespace :admin do
    resources :orders, only: %i[index]
    resources :shipping_companies
    resources :products, only: %i[new create index show] do
      resources :orders, only: %i[new create]
    end
  end

  namespace :user do
    resources :shipping_companies, only: %i[show update edit] do
      resources :shipping_statuses, only: %i[new create]
      resources :orders, only: %i[show update edit index]
      resources :vehicles, only: %i[ new create index]
    end
  end
end
