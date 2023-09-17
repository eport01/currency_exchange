Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :currency, only: [:index] 
  resources :users 

  get "/login", to: "users#login"
end
