Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"

    get "/signup", to: "users#new", as: "signup"

    resources :users
  end
end
