Rails.application.routes.draw do
  devise_for :users
  
  authenticated :user do
    root :to => "posts#index", :as => "user_authenticated_root"
  end

  root 'home#top'
  get 'about', to: 'home#about'
  get 'searches', to: 'searches#search'
  get 'tags/:tag', to: 'posts#index', as: :tag

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

