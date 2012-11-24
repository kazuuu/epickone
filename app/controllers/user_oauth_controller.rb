class UserOauthController < ApplicationController
  def exctract_locale_from_url(url)
    url[/^([^\/]*\/\/)?[^\/]+\/(\w{2})(\/.*)?/,2]
  end
  def create
    begin
      @current_user = User.find_or_create_from_oauth(env["omniauth.auth"])
    rescue => ex
      flash[:notice] = "[Error] " + ex.message 
      logger.error "[Error] " + ex.message      
    end
    I18n.locale = exctract_locale_from_url(request.env['omniauth.origin']) if request.env['omniauth.origin']
          
    if current_user
      UserSession.create(current_user, true)
      redirect_to root_url, :notice => "Logged in"
    else
      redirect_to root_url, :flash => {:error => "Not authorized"}
    end
  end
  
  def failure
    redirect_to root_url, :flash => {:error => "Not authorized. #{params[:message]}"}
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end