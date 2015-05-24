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
    @user = User.find_using_perishable_token(params[:id])
  end

  def update
    @user = User.find_using_perishable_token(params[:id])
    @user.password = params[:user][:password]

    respond_to do |format|
      if @user.valid_attribute?(:password, params[:user][:password])
        @user.save_without_session_maintenance(:validate => false)
        format.html { redirect_to :login, notice: 'Sua senha foi atualizada.' }
        format.json { head :no_content }
      else
        flash[:error] = "Sua senha precisa ter no mínimo 4 caracteres."
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Este link está vencido. Clique em esqueci minha senha novamente."
      redirect_to root_url
    end
  end
end