Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :operations, only: [:index, :show, :new, :create]
  end
  
  # Defines the root path route ("/")
  root "users#index"
end
