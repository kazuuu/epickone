class Notifier < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default :from => "no-reply@ebocao.com"

  def activation(user)
    @user = user    
    @url  = activation_url(@user.perishable_token)
#    @url  = how_to_win_url
    mail(
        :to => user.email,
        :subject => "Activation Instructions"  
      )
  end

  def welcome(user)
    @user = user    
    @url  = root_url
    mail(
        :to => user.email,
        :subject => "Welcome to ePickOne.com!"  
      )
  end

  def password_reset_instructions(user)
    @user = user
    @url = edit_password_reset_url(@user.perishable_token)
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
