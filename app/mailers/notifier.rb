class Notifier < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default :from => "no-reply@ebocao.com"

  def password_reset_instructions(user)
    @user = user
    mail(
        :to => user.email,
        :subject => "Password Reset Instructions"  
      )
  end

  def welcome(user)
    @user = user    
    @url  = "http://epickone.com/login"
    mail(
        :to => user.email,
        :subject => "Welcome to ePick One!"  
      )
  end   
end
