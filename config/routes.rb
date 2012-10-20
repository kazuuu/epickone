Pickone::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"


  resources :draws

  resources :users, :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
end
