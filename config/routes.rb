Rails.application.routes.draw do
  resources :comments
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :cars
  root 'cars#index'
  get 'mycars', to: 'cars#my_cars'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
