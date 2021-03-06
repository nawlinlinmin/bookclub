Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'

  post '/users/sign_in_as_a_guest', to: 'users#guest'
  post '/users/sign_in_as_an_admin', to: 'users#admin'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'user/:id', to: 'users/registrations#detail'
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end

  root 'books#index'
  resources :books, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :comments, only: [:edit, :update]
  resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end

  namespace :admin do
    root 'books#index'
    resources :books do
      resources :comments, only: [:create, :destroy]
    end
    resources :comments, only: [:index, :edit, :update, :destroy]
    resources :reviews
    resources :favorites, only: [:index, :create, :destroy]
    resources :users
    resources :relationships, only: [:index, :create, :destroy]
  end

end
