Rails.application.routes.draw do
  resources :withdraws
  resources :deposits
  resources :accounts
  get 'wellcome/index'
  devise_for :users
  root to:"wellcome#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end