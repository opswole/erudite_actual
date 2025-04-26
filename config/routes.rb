Rails.application.routes.draw do
  root to: "home#index", as: "root"

  resources :notebooks, only: %i[ edit update show ]
  resources :assignments, only: %i[ index show ]

  resources :messages
  resources :conversations
  # Authentication
  resource :session
  resources :passwords, param: :token

  resources :users, only: %i[ show edit update ]
  resources :mentions
  resources :notifications
  resources :overviews
  resources :timetables, only: %i[ index show ]
  resources :units, only: [ :index, :show ]
  resources :topics, only: [ :index, :show ]

  # /admin
  namespace :admin do
    root to: "home#index", as: "root"
    get "/users", to: "users#list", as: "users_list"
    resources :assignments do
      member do
        delete :remove_attachment
      end
    end
    resources :users
    resources :audits
    resources :courses do
      resources :course_ownerships
    end
    resources :units
    resources :attachments, only: %i[ destroy ]
    resources :topics do
      member do
        delete :remove_attachment
      end
    end

    resources :home
    resources :overviews
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
