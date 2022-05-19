Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  devise_for :admins
  root to: 'home#index'

  get '/products/:id', to: 'home#display_product', as: 'show_product'

  namespace :admin do
    resources :shipping_companies
    resources :orders
  end
end
