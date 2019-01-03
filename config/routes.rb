Rails.application.routes.draw do
  devise_for :users
  root to: 'memes#index'
  
	resources :memes
end
