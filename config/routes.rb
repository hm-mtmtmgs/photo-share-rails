Rails.application.routes.draw do
  get "/", to: "home#index"

	get "posts/search", to: "posts#search"
	post "posts/search", to: "posts#search"
  get "posts/show"
  get "posts/add", to: "posts#add"
	post "posts/add", to: "posts#add"
  get "posts/edit"

  get "users/search", to: "users#search"
	post "users/search", to: "users#search"
  get "signup", to: "users#add"
	post "signup", to: "users#add"
	get "login", to: "users#login"
	post "login", to: "users#login"
	delete "logout", to: "users#logout"
	resources :users, param: :username, path: "/", only: [:show, :edit, :update]
end
