class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Foi enviado um email com as instruções para recuperar sua senha. Verifique sua caixa postal."
      redirect_to root_path
    else
      flash.now[:error] = "Nenhum usuário encontrado com o email #{params[:email]}"
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:password]
    # Only if your are using password confirmation
    # @user.password_confirmation = params[:password]

    # Use @user.save_without_session_maintenance instead if you
    # don't want the user to be signed in automatically.
    if @user.save
      flash[:success] = "Sua senha foi atualizada."
      redirect_to @user
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Não foi possível localizar seu cadastro."
      redirect_to root_url
    end
  end
end