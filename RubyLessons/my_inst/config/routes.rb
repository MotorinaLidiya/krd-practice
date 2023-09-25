Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts
  get :profile, to: 'posts#profile'
end
