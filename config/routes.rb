Rails.application.routes.draw do
  devise_for :users

  root 'home#top'

  resources :posts
  resources :users do
    resource :relationship
    resources :followings
    resources :followers
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

