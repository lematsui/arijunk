Rails.application.routes.draw do
  devise_for :users
  root to: 'memes#index'
  
	resources :memes
	post '/upvote', to: 'memes#upvote'
	post '/downvote', to: 'memes#downvote'
end
