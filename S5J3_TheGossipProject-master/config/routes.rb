Rails.application.routes.draw do

 
	get root 'gossips#index'
	get 'about/welcome/:first_name', to: 'about#welcome'
	get 'about/team'
	get 'about/contact'

	resources :gossips do
	  resources :comments
	end
	resources :users
	resources :cities
	resources :sessions, only: [:new, :create, :destroy]

end

