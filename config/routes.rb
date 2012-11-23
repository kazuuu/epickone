Pickone::Application.routes.draw do
#  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  resources :users do
    get 'credits', :on => :member 
    get 'wincredits', :on => :member 
    get 'facebook_share_draw', :on => :member 
  end

  resources :password_resets, :only => [ :new, :create, :edit, :update ]
#  resource :activation, :only =>  [ :new, :create, :edit, :update ]
#  activate '/activate/:activation_code', :controller => 'activations', :action => 'create'
  resources :user_sessions

  resources :credits


  resources :answers

  resources :questions

  resources :draw_images

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

  resources :carts do
    get 'checkout', :on => :member
    get 'payment_not_needed', :on => :member
  end
  resources :cartitems
  resources :payment_notifications

  
  match '/how_to_win',    to: 'static_pages#how_to_win'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/admin', to: 'admin#admin'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match '/activation/:activation_code', to: 'activation#create', :as => 'activation'

#  end  


#  match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
#  match '', to: redirect("/#{I18n.default_locale}")
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :prefix_on_default_locale => true })

Pickone::Application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'static_pages#home'
  end  
  ActiveAdmin.routes(self)  
#  resources :activations, :only => [ :new, :create, :edit, :update ]
  
  match '/auth/:provider/callback' => 'user_oauth#create', :as => :callback
  match '/auth/failure' => 'user_oauth#failure', :as => :failure

  match '/auth/facebook' => 'user_oauth#create', :as => :fb_login
  match '/auth/twitter' => 'user_oauth#create', :as => :tw_login

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  match '', to: redirect("/#{I18n.default_locale}")
end

