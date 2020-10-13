Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  get 'about', to: 'home#about'
  get 'searches', to: 'searches#search'

  resources :posts do
    resource :like
    resources :comments
  end
  resources :users do
    resource :relationship
    resources :followings
    resources :followers
    resources :likes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

