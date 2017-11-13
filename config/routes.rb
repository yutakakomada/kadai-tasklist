Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :tasks
  resources :users, only: [:index, :show, :new, :create, :edit]
end
