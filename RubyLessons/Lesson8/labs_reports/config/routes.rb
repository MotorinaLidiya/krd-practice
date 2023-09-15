Rails.application.routes.draw do
  devise_for :users
  root to: 'labs#index'

  resources :labs, only: %i[index new create destroy] do
    get :grade, on: :member
    patch :mark, on: :member
  end
end
