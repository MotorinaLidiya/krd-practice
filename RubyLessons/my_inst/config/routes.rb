Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts 
  get :profile, to: 'posts#profile'

  namespace :api do
    resources :post_comments, only: %i[create destroy]
    namespace :post_reactions do
      post :like
      post :dislike
    end
  end

end
