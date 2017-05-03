Rails.application.routes.draw do

  root 'users#index'

  resource :users
  resource :questions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'show' => 'users#show'
  #get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
