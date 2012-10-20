class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  def require_user
    unless current_user 
      flash[:notice] = "Please sign in to access this page"
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
    redirect_to root_url unless ((@user.id == current_user.id) || (current_user.admin_flag))
    return false
  end
  def require_admin
    redirect_to root_url unless (current_user.admin_flag)
    return false
  end
end
