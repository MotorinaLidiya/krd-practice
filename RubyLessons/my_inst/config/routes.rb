Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get :profile, to: 'users#profile'

  resources :posts, except: :show
  resources :users, only: :show do
    post 'subscribe', on: :member
    post 'unsubscribe', on: :member
    get 'subscribtions', on: :collection
  end

  namespace :api do
    resources :post_comments, only: %i[create destroy]
    namespace :post_reactions do
      post :like
      post :dislike
    end
  end
end
