class Notifier < ActionMailer::Base
#  default_url_options[:host] = "www.epickone.com.br"
  default :from => "ePick One <epickone-noreply@epickone.com.br>"

  def activation(user)
    @user = user    
    @url  = activation_url(@user.perishable_token)
    mail(
        :to => user.email,
        :subject => t("notifier.activation.subject")  
      )
  end

  def email_activation(email)
    @email = email
    @url  = email_activation_url(@email.token)
    mail(
        :to => email.email,
        :subject => "Confirme seu email"
      )
  end


  def welcome(user)
    @user = user    
    @url  = root_url
    mail(
        :to => user.email,
        :subject => t("notifier.welcome.subject")   
      )
  end

  def password_reset_instructions(user)
    @user = user
    @url = edit_password_reset_url(@user.perishable_token)
    mail(
        :to => user.email,
        :subject => t("notifier.password_reset.subject") 
      )
  end

  def welcome(user)
    @user = user    
    @url  = "http://epickone.com.br/login"
    mail(
        :to => user.email,
        :subject => "Welcome to ePick One!"  
      )
  end   
end
