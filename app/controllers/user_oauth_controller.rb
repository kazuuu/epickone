class UserOauthController < ApplicationController
  skip_before_filter :site_lock
  
  def exctract_locale_from_url(url)
    url[/^([^\/]*\/\/)?[^\/]+\/(\w{2})(\/.*)?/,2]
  end
  def create
    begin
      aTeste = env["omniauth.auth"]
      
      if aTeste.provider == 'facebook'
        @current_user = User.find_or_create_from_oauth(env["omniauth.auth"])
      elsif aTeste.provider == 'twitter'
        current_user.update_attributes({
          :twitter_uid => aTeste["uid"],
          :twitter_oauth_token => aTeste["credentials"]["token"],
          :twitter_oauth_secret => aTeste["credentials"]["secret"],
          :twitter_oauth_expires_at => 30.day.from_now
            })
      end
    rescue => ex
      flash[:notice] = "[Error] " + ex.message 
      logger.error "[Error] " + ex.message      
    end
    lang = exctract_locale_from_url(request.env['omniauth.origin']) if request.env['omniauth.origin']
    lang = :"pt-BR" if lang == "pt"
    I18n.locale = lang
          
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