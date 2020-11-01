Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"

    get "/signup", to: "users#new", as: "signup"
    get "/login", to: "sessions#new", as: "login"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy", as: "logout"
    patch "/courses/:id", to: "courses#update", as: "update_course"

    resources :users
    resources :courses
  end
end
