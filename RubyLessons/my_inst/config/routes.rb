Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'home#index'
  resources :posts, except: :show
  get :profile, to: 'posts#profile'
  resources :users, only: :show do
    post 'subscribe', on: :member, to: 'subscribers#create', as: 'subscribe'
    delete 'unsubscribe', on: :member, to: 'subscribers#destroy', as: 'unsubscribe'
  end
  resources :subscribers, only: %i[create destroy]
  
  namespace :api do
    resources :post_comments, only: %i[create destroy]
    namespace :post_reactions do
      post :like
      post :dislike
    end
  end

end
