Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new]

  get 'sign_up' => 'users#new'
  get 'user_destroy' => 'users#destroy'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

end
