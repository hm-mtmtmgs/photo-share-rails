Rails.application.routes.draw do
  get '/', to: 'home#index'

  get 'posts/index'
  get 'posts/show'
  get 'posts/add'
  get 'posts/edit'

  get 'users/index'
  get 'users/show'
  get 'signup', to: 'users#add'
	post 'signup', to: 'users#add'
  get 'users/edit'
	get 'login', to: 'users#login'
	post 'login', to: 'users#login'
end
