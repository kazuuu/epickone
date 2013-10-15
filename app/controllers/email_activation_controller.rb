class EmailActivationController < ApplicationController
  def create
    @email = Email.find_by_token(params[:email_activation_code])
    
    if !@email.nil?
      @email.activate!
      flash[:notice] = @email.email + " está confirmado!"
    else
      flash[:error] = "E-mail não foi confirmado, tente novamente."
    end
    redirect_to root_url
  end
end
