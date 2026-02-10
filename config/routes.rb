Rails.application.routes.draw do
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  resources :workshops, only: %i[index show]
  resources :bookings, only: %i[create]
end
