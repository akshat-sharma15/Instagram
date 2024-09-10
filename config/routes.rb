Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    registrations: 'users/registrations'
                                  }

  resources :relationships, only: [:create, :destroy, :index]

  resources :users do
    member do
      get :following, :followers
      post :follow, :unfollow
    end
  end

  resources :users do
    resources :posts, only: [:create, :update, :new]
  end

  resources :posts, only: [:show]

  resource :relationships, only: [:create, :destroy]
  get '/search', to: 'app#search'
  get '/explore', to: 'app#explore'
  get '/reels', to: 'app#reels'
  get '/messages', to: 'app#messages'
  get '/notifications', to: 'app#notifications'
  get '/create_post', to: 'posts#new'

  root "app#home"
end
