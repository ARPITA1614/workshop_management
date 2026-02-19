Rails.application.routes.draw do
  devise_for :customers
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => "/cable"


  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions",
    passwords: "admin_users/passwords"
  }
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resources :refunds do
    get :refund_acceptance, on: :member
  end

  resources :workshops, only: %i[index show]
 resources :bookings, only: [ :index, :show, :create ] do
  get :booking_details, on: :member
  collection do
    get :success
  end
end
     
get "/check_admin", to: "admin_setup#check"

  namespace :admin do
    get "dashboard" => "dashboard#index"
    resources :workshops
    resources :bookings
    resources :customers
    resources :refunds do
      member do
        patch :process_refund
      end
    end
  end

  post "/webhooks/stripe", to: "webhooks#stripe"
  get '/test-email', to: 'home#test_email'
end
