Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

   # Authentication routes
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy"

    # Password reset routes
    get  "password/reset", to: "passwords#new"
    post "password/reset", to: "passwords#create"
    get  "password/reset/edit", to: "passwords#edit"
    patch "password/reset/edit", to: "passwords#update"

    resources :books do
      member do
        post :borrow
      end
    end
  
    resources :borrowings, only: [:index] do
      member do
        patch :return
      end
    end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
 root "home#index"
end
