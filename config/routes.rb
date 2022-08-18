Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :bookings, only: [:index, :update]
  resources :vinyls, only: [:index, :show, :create, :new]
  resources :offers, only: [:new, :show, :index, :create] do
    resources :bookings, only: [:create]
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
