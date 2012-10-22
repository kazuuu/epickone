Pickone::Application.routes.draw do
  resources :drawships

  resources :answers

  resources :questions

  get "admin/draws"

  get "account/account"

  resources :draws do
    get 'join', :on => :member 
  end
  resources :users, :user_sessions

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/admin', to: 'admin#admin'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
end
