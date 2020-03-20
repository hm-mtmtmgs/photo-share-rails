Rails.application.routes.draw do
  get "/", to: "home#index"

  get "posts/index"
  get "posts/show"
  get "posts/add"
  get "posts/edit"

  get "users/search", to: "users#search"
	post "users/search", to: "users#search"
  get "signup", to: "users#add"
	post "signup", to: "users#add"
	get "login", to: "users#login"
	post "login", to: "users#login"
	delete "logout", to: "users#logout"
	get "users/edit"
	resources :users, param: :username, path: "/", only: [:show]
end
