Rails.application.routes.draw do
  get 'balance/index'
  post 'balance/index'
  resources :transfers, only:[:index, :create, :show, :new]
  resources :withdraws, only:[:index, :create, :show, :new]
  resources :deposits, only:[:index, :create, :show, :new]
  resources :accounts, except:[:index, :create, :show, :new]
  devise_for :users
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"wellcome#index"
  get 'wellcome/index'
end
