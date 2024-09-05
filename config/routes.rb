Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :relationships, only: [:create, :destroy, :index]

  resources :users do
    member do
      get :following, :followers
      post :follow, :unfollow
    end
  end

  resource :relationships, only: [:create, :destroy]

  root "app#home"
end
