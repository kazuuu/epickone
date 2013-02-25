Epickone::Application.routes.draw do
  resources :products do
    resources :photos
  end

  # scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  # scope ":locale_city", site_city: /#{LOCALE_CITY_AVAILABLE.join("|")}/ do
    resources :users do
      get 'wintickets', :on => :member 
      get 'facebook_share_event', :on => :member 
      get 'twitter_share_event', :on => :member 
      get 'resend_activation', :on => :member     
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
      get 'join_paid', :on => :member 
      get 'quiz', :on => :member
      post 'quiz_result', :on => :member
      get 'add_cart', :on => :member
    end

    resources :carts do
      get 'add_ticket_number', :on => :member
      post 'add_tickets', :on => :member
      get 'checkout', :on => :member
      get 'pick_a_number', :on => :member
      get 'payment_not_needed', :on => :member
    end

    resources :tickets

    resource :store, :controller => 'store' do
      resources :categories
      resources :products
    end

    match '/how_it_works',    to: 'static_pages#how_it_works'
    match '/help',    to: 'static_pages#help'
    match '/faq',    to: 'static_pages#faq'
    match '/privacy',    to: 'static_pages#privacy'
    match '/term',    to: 'static_pages#term'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'

    match '/admin', to: 'admin#admin'

    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout
    match '/activation/:activation_code', to: 'activation#create', :as => 'activation'

  # end
  # end
#   match '*path', to: redirect("/#{I18n.default_locale}/rio_de_janeiro/%{path}")
#   match '', to: redirect("/#{I18n.default_locale}/rio_de_janeiro")
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :prefix_on_default_locale => true })

Epickone::Application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  #scope ":site_city", site_city: /sao_paulo|rio_de_janeiro/, :defaults => {:site_city => "sao_paulo"} do
      root to: 'static_pages#home'
    
      # handles /valid-locale/fake-path
      #match '*path', to: redirect { |params, request| "/#{params[:locale]}/#{params[:site_city]}" }
      match '*path', to: redirect { |params, request| "/#{params[:locale]}" }
    #end
  end  

  ActiveAdmin.routes(self)  
  
  match '/auth/:provider/callback' => 'user_oauth#create', :as => :callback
  match '/auth/failure' => 'user_oauth#failure', :as => :failure

  match '/auth/facebook' => 'user_oauth#create', :as => :fb_login
  match '/auth/twitter' => 'user_oauth#create', :as => :tw_login

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  match '', to: redirect("/#{I18n.default_locale}")
  #match '*path', to: redirect("/#{I18n.default_locale}/sao_paulo/%{path}")
  #match '', to: redirect("/#{I18n.default_locale}/sao_paulo")
end

