Rails.application.routes.draw do
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  resources :workshops, only: %i[index show]
  resources :bookings, only: [ :create ] do
    collection do
      get :success
    end
  end 

  post "/webhooks/stripe", to: "webhooks#stripe"
end
