Rails.application.routes.draw do
  get '/', to: 'home#index'

  get 'posts/index'
  get 'posts/show'
  get 'posts/add'
  get 'posts/edit'

  get 'users/index'
  get 'users/show'
  get 'users/add'
  get 'users/edit'
	get 'login', to: 'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
