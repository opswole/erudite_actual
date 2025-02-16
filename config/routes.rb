Rails.application.routes.draw do
  # Authentication
  resource :session
  resources :passwords, param: :token

  # Default / behaviour
  root to: "user/home#index"

  # Pages with /admin prefix
  namespace :admin do
    resources :admins_home
    root to: "admins_home#index"
  end

  # Pages with /user prefix
  namespace :user do
    get "/profile", to: "profiles#show"
    get "/notifications", to: "notifications#index"
    get "/home", to: "home#index"
    get "/tab/overview", to: "tabs#overview"
    get "/tab/courses", to: "tabs#courses"
    get "/tab/messages", to: "tabs#messages"
    get "/tab/timetable", to: "tabs#timetable"
  end

  # Course testing against S3
  get "/courses", to: "courses#index"

  # Footer pages
  get "/sitemap" => "sitemaps#index", as: :sitemap
  get "/terms" => "terms#index", as: :terms
  get "/privacy" => "privacies#index", as: :privacy
  get "/accessibility" => "accessibilities#index", as: :accessibility
  get "/contact" => "contacts#index", as: :contact

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
