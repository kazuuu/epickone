class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_locale_from_url
  
  helper_method :current_user, :cart_count, :current_cart

# Para trancar o site
#  before_filter :site_lock 


  def store_location
    session[:return_to] = request.fullpath if request.get? and controller_name != "user_sessions" and controller_name != "sessions"
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
  end

  private
  def set_locale
    if lang = request.env['HTTP_ACCEPT_LANGUAGE']
      lang = lang[/^[a-z]{2}/]
      lang = :"pt-BR" if lang == "pt"
    end
    I18n.locale = params[:locale] || lang || I18n.default_locale
  end    
  def default_url_options(options = {})
    {locale: I18n.locale}
  end
    
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  def current_user_admin
    return @current_user.admin_flag
  end
  def require_user
    unless current_user
      store_location 
      flash[:notice] = "Para continuar é necessário se identificar."
      redirect_to :login
      return false
    end
  end 
  def require_no_user 
    if current_user 
      flash[:notice] = "Please sign out to access this page"
      redirect_to root_url
      return false
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless ((@user.id == current_user.id) || (current_user.admin_flag))
      flash[:notice] = "You do not have permission"
      redirect_to root_url 
      return false
    end
  end
  def require_user_admin
    unless current_user && current_user_admin
      flash[:notice] = 'You must be logged as administrador to access this page'
      redirect_to root_url
      return false
    end
  end  
  def current_cart
    if current_user    
      @current_cart = nil
    
      current_user.carts.each do |cart|
        @current_cart = cart if cart.purchased_at.nil?
      end
    
      if @current_cart.nil?
        @current_cart = current_user.carts.build()
        @current_cart.save
      end
      
      @current_cart
    end
  end 
  
  protected  
    def rescue_action_in_public(exception)
      case exception
      when ActiveRecord::RecordNotFound
        render :file => "#{RAILS_ROOT}/puclic/404.html", :status => 404
      else
        super
      end
    end
    
  protected

      def site_lock
        authenticate_or_request_with_http_basic do |username, password|
          username == "guest" && password == "1010"
        end
      end
     
end
