Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'show' => 'users#show'
  #get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root 'users#show'
end
