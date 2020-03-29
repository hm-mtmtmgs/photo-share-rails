Rails.application.routes.draw do
  root "home#index"

	get "posts/search", to: "posts#search"
	post "posts/search", to: "posts#search"
  get "posts/show/:id", to: "posts#show"
  get "posts/add", to: "posts#add"
	post "posts/add", to: "posts#add"
  get "posts/edit"
	get "posts/delete/:id", to: "posts#destroy"

  get "users/search", to: "users#search"
	post "users/search", to: "users#search"
  get "signup", to: "users#add"
	post "signup", to: "users#add"
	get "login", to: "users#login"
	post "login", to: "users#login"
	delete "logout", to: "users#logout"
	resources :users, param: :username, path: "/", only: [:show, :edit, :update]
	resources :users, param: :username do
		member do
			get :following, :follower
		end
	end

	post "/likes/:post_id/create", to: "likes#create"
	delete "/likes/:post_id/delete", to: "likes#destroy"

	resources :relationships, only:[:create, :destroy]
end
