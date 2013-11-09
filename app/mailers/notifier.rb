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

  def password_reset_instructions(user)
    @user = user
    @url = edit_password_reset_url(@user.perishable_token)
    mail(
        :to => user.email,
        :subject => "Instruções para cadastrar nova senha"
      )
  end

  def welcome(user)
    @user = user    
    @url  = "http://www.epickone.com.br/login"
    mail(
        :to => user.email,
        :subject => "Sua senha, lembre-se de trocar"
      )
  end   
end
