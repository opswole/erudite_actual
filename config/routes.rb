Rails.application.routes.draw do
  # Authentication
  resource :session
  resources :passwords, param: :token

  # Default / behaviour
  root to: "user/home#index"

  # /admin
  namespace :admin do
    root to: "dashboard#index"
    resources :users
    resources :audits
    resources :courses do
      resources :units
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
    get "/profile", to: "profiles#show"
    get "/notifications", to: "notifications#index"
    get "/home", to: "home#index"
    get "/tab/index", to: "tabs#index"
    get "/tab/units", to: "tabs#units"
    get "/tab/messages", to: "tabs#messages"
    get "/tab/timetable", to: "tabs#timetable"
  end

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
