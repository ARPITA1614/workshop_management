Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions",
    passwords: "admin_users/passwords"
  }
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  resources :workshops, only: %i[index show]
  resources :bookings, only: [ :create ] do
    get :booking_details, on: :member
    collection do
      get :success
    end
  end 

  namespace :admin do
    get "dashboard" => "dashboard#index"
  end

  post "/webhooks/stripe", to: "webhooks#stripe"
end
