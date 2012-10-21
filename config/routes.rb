Pickone::Application.routes.draw do
  get "admin/draws"

  get "account/account"

  resources :draws
  resources :users, :user_sessions
  resources :draws, only: [:create, :destroy]

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/admin', to: 'admin#admin'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
end
