class EmailsController < ApplicationController
  def index
    @user = current_user
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user.id) + "/#t_tab1", notice: 'Email removido.' }
      format.json { head :no_content }
    end
  end

  def create
    @email = current_user.emails.build(params[:email]) 
    respond_to do |format|
      if @email.save
        @email.deliver_activation!
        format.html { redirect_to user_path(current_user.id) + "/#t_tab1", notice: 'Email criado.' }
        format.json { render json: @email, status: :created, location: @email }
      else
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end
  def new
    @email = current_user.emails.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email }
    end
  end

  def set_default
    user = current_user
    email = Email.find(params[:id])
    new_email = Email.new
    
    if email.valid_email
      new_email.email = email.email
      new_email.valid_email = email.valid_email
    
    
      email.email = user.email
      email.valid_email = user.valid_email
      email.save
    
      user.email = new_email.email
      user.valid_email = new_email.valid_email
      user.save
    
      redirect_to user_path(current_user.id) + "/#t_tab1", notice: 'E-mail principal alterado.' 
    else
      flash[:error] = 'Favor confirmar este e-mail antes de defini-lo como seu e-mail principal.' 
      redirect_to user_path(current_user.id) + "/#t_tab1"
    end
  end
  def send_confirmation
    email = Email.find(params[:id])
    email.deliver_activation!
    redirect_to user_path(current_user.id) + "/#t_tab1", notice: 'Foi enviado um link de confirmação para o e-mail solicitado. Favor verificar.' 
  end
end
