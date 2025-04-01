Rails.application.routes.draw do
  resources :assignments
  resources :mentions
  resources :messages
  # Authentication
  resource :session
  resources :passwords, param: :token

  resources :users

  # Default / behaviour
  root to: "user/home#index"

  # /admin
  namespace :admin do
    root to: "dashboard#index"
    # TODO: Make this RESTFUL
    get "users/list", to: "users#list", as: "users_list"
    resources :users
    resources :audits
    resources :courses
    resources :units
    resources :topics do
      member do
        delete :remove_attachment
      end
    end
    resources :dashboard, only: [ :index ]
    get "dashboard/overview", to: "dashboard#overview"
    get "dashboard/courses", to: "courses#index"
    get "dashboard/users", to: "users#index"
  end

  # /users
  namespace :user do
    root to: "home#index"
    resources :units, only: [ :index, :show ]
    resources :topics, only: [ :index, :show ]
    resources :messages
    resources :notifications
    resources :timetables
    resources :overviews
    post "/search", to: "users#search", as: :search
    get "/profile", to: "profiles#show"
    get "/home", to: "home#index"
  end

  resources :messages

  # Footer pages
  get "/sitemap", to: "footer#show", defaults: { page: "sitemap" }
  get "/terms", to: "footer#show", defaults: { page: "terms" }
  get "/privacy", to: "footer#show", defaults: { page: "privacy" }
  get "/accessibility", to: "footer#show", defaults: { page: "accessibility" }
  get "/contact", to: "footer#show", defaults: { page: "contact" }

  # 403 test
  get "/access-denied", to: "errors#access_denied", as: :access_denied

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
