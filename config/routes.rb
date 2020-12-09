Rails.application.routes.draw do
  resources :comments
  resources :contacts, only: [:new, :create]
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :cars
  root 'cars#index'
  get '/search', to: 'cars#search'
  get '/garage/:id', to: 'cars#garage', as: 'garage'
  get '/FAQs', to: 'cars#FAQs', as: 'faqs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
