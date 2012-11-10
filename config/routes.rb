Pickone::Application.routes.draw do
  resources :credits

  ActiveAdmin.routes(self)

  resources :answers

  resources :questions

  get "account/account"

  resources :draws do
    get 'results', :on => :member 
    get 'join_promo', :on => :member 
    get 'join_paid', :on => :member 
    get 'join_questions', :on => :member
    post 'questions_check', :on => :member
    get 'pick_a_number', :on => :member
    get 'pick_a_number_promo', :on => :member
    get 'add_cart', :on => :member
  end
  
  resources :users, :user_sessions

  resources :carts do
    get 'checkout', :on => :member
    get 'payment_not_needed', :on => :member
  end
  resources :cartitems
  resources :payment_notifications

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/admin', to: 'admin#admin'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
  match '/auth/:provider/callback' => 'user_oauth#create', :as => :callback
  match '/auth/failure' => 'user_oauth#failure', :as => :failure
  
  match '/auth/facebook' => 'user_oauth#create', :as => :fb_login
  match '/auth/twitter' => 'user_oauth#create', :as => :tw_login
  
end
