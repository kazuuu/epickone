class ActivationController < ApplicationController
  before_filter :require_no_user

  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?

    if @user.activate!
      flash[:notice] = "Sua conta foi ativada!"
      UserSession.create(@user, false)
      @user.deliver_welcome!
      redirect_to root_url
    else
      render :action => :new
    end
  end
end
