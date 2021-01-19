Rails.application.routes.draw do
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"

    get "/signup", to: "users#new", as: "signup"
    get "/login", to: "sessions#new", as: "login"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy", as: "logout"
    get "/course/list", to: "user_courses#index"

    resources :users
    resources :user_courses
    resources :course_lectures do
      resources :comments
    end
    resources :courses do
      resources :comments
    end
    resources :complete_courses
    resources :my_courses

    namespace :admin do
      root "dashboard#index"

      resources :courses
      resources :users
      resources :categories
      resources :user_courses
      resources :student_managements
    end
  end
end
