Rails.application.routes.draw do
	root "home#index"
	
	resources :ranking, only:[:index]

	resources :posts do
		collection do
			get :create, :search
			post :search
		end
		member do
			get :like, :show
		end
	end

	resources :users do
		collection do
			get :signup, :search
			post :signup, :search
		end
	end
	
	get "signup", to: "users#create"
	post "signup", to: "users#create"
	get "login", to: "users#login"
	post "login", to: "users#login"
	delete "logout", to: "users#logout"
	
	resources :users, param: :username, path: "/" do
		member do
			get :show, :edit, :following, :follower, :setting
			post :setting
			patch :setting
			delete :setting
		end
	end
	
	resources :likes, param: :post_id do
		member do
			post :create
		end
	end
			
	resources :relationships, only:[:create, :destroy]

	resources :comments, only:[:create, :destroy]
end
