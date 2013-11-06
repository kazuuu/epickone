Epickone::Application.routes.draw do
  resources :emails do
    get 'set_default', :on => :member 
    get 'send_confirmation', :on => :member 
  end
  resources :cities
  resources :quizzes

  resource :tools do
    post 'event_clone', :on => :member 
  end

  resources :products do
    resources :photos
  end
  
  resources :users do
    get 'mobile_phone' => "users#mobile_phone", :on => :member     
    put 'mobile_phone' => "users#set_mobile_phone", :on => :member
    get 'password' => "users#password", :on => :member     
    put 'password' => "users#set_password", :on => :member
    get 'wintickets', :on => :member 
    get 'facebook_share_event', :on => :member 
    get 'twitter_share_event', :on => :member 
    get 'resend_activation', :on => :member     
    get 'send_mobile_phone_verification', :on => :member     
    post 'mobile_phone_verification', :on => :member     
    get 'valid_mobile' => "users#new_user_valid_mobile", :on => :member     
    put 'valid_mobile' => "users#new_user_set_mobile", :on => :member
    post 'add_tickets', :on => :member
    get 'valid_mobile_later_on', :on => :member     

    resources :tickets do
      get 'submit_it', :on => :member
      get 'validation', :on => :member
      post 'add_number', :on => :member
    end
  end
  
  resources :payment_notifications

  resources :password_resets, :only => [ :new, :create, :edit, :update ]
  resources :user_sessions

  resources :answers

  resources :questions
  
  resources :lacale_city do
    get 'sao_paulo', :on => :member 
    get 'rio_de_janeiro', :on => :member 
  end
  
  get "account/account"

  resources :events do
    resources :photos
    get 'results', :on => :member 
    get 'join_promo', :on => :member 
    get 'quiz', :on => :member
    post 'right_answer_check', :on => :member
  end

  resource :store, :controller => 'store' do
    resources :categories
    resources :products
  end

  match '/how_it_works', to: 'static_pages#how_it_works'
  match '/help',         to: 'static_pages#help'
  match '/faq',          to: 'static_pages#faq'
  match '/privacy',      to: 'static_pages#privacy'
  match '/term',         to: 'static_pages#term'
  match '/about',        to: 'static_pages#about'
  match '/contact',      to: 'static_pages#contact'
  match '/msgbox',          to: 'static_pages#msgbox'
  match '/admin',        to: 'admin#admin'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match '/activation/:activation_code', to: 'activation#create', :as => 'activation'
  match '/email_activation/:email_activation_code', to: 'email_activation#create', :as => 'email_activation'
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :prefix_on_default_locale => true })

Epickone::Application.routes.draw do
  resources :quizzes


  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'static_pages#home'
  
    match '*path', to: redirect { |params, request| "/#{params[:locale]}" }
  end  

  ActiveAdmin.routes(self)  
  
  match '/auth/:provider/callback' => 'user_oauth#create', :as => :callback
  match '/auth/failure' => 'user_oauth#failure', :as => :failure

  match '/auth/facebook' => 'user_oauth#create', :as => :facebook_login
  match '/auth/twitter' => 'user_oauth#create', :as => :twitter_login

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  match '', to: redirect("/#{I18n.default_locale}")
end

