class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        @user = User.find_by_email(@user_session.email)
        back_path = session[:return_to]
        session.delete(:return_to)
        if @user.login_count == 1
          @user.set_valid_email(true) 
          begin
            result = @user.send_sms_mobile_phone_code
          rescue Clickatell::API::Error => e
            flash[:error] = "Número de telefone inválido. Favor corrigir."
            # flash[:error] = "Clickatell API error: #{e.message}"
          end
        end
        
        if !@user.valid_mobile_phone?
          format.html { redirect_to(user_path(@user) + "/#t_tab1", :notice => 'Favor validar seu número de celular através do código que você recebeu por SMS.') }
          format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
        else
          format.html { redirect_to(back_path || root_path, :notice => 'Seja bem vindo(a) e tenha uma ótima diversão!') }
          format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
        end
      elsif @user_session.attempted_record &&
          !@user_session.invalid_password? &&
          !@user_session.attempted_record.active?
          format.html { redirect_to(root_path, :notice => 'Favor confirmar seu email para prosseguir. Verifique em sua caixa postal o email de confirmação que foi enviado agora.') }
          format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    session.clear
    
    respond_to do |format|
      format.html { redirect_to(root_path, :notice => 'Volte sempre! Afinal, não custa nada tentar.') }
      format.xml  { head :ok }
    end
  end
end
