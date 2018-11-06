Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]

  get '/zomg', to: 'customers#zomg'

  resources :rentals, only: [:index, :show, :create]

  # post '/rental', to: 'rentals#create', as: 'checkout'

end
