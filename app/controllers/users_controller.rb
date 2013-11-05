include CommomFunctions

class UsersController < ApplicationController
 before_filter :require_no_user,  :only => [:new]
 before_filter :require_user, :except => [:new, :create, :update_city_select]
 before_filter :correct_user, :only => [:show, :edit, :update]
 before_filter :require_user_admin,  :only => [:index]
 skip_before_filter :require_valid_mobile_phone,    :only => [:valid_mobile_later_on, :valid_mobile, :set_mobile, :send_mobile_phone_verification, :mobile_phone_verification]
 skip_before_filter :require_all_tickets_validated, :only => [:valid_mobile_later_on, :valid_mobile, :set_mobile, :send_mobile_phone_verification, :mobile_phone_verification]

# GET /users
# GET /users.json
  def index
    # @users = User.all # Authlogic
    @users = User.paginate(page: params[:page], :per_page => 10) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @tickets_new = current_user.tickets.find_running.find_not_validated
    @tickets_validated = @user.tickets.find_running.find_validated
    @tickets_old = @user.tickets.find_old.find_validated
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @states = State.find_all_by_country_id(1)
    @cities = City.find_all_by_state_id(0)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @states = State.find_all_by_country_id(@user.country_id)
    @cities = City.find_all_by_state_id(params[:user][:state_id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Dados atualizados.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @states = State.find_all_by_country_id(@user.country_id)
    @cities = City.find_all_by_state_id(@user.state_id)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.password = char_generator(4)
    @user.country_id = 1
    @user.active = true
    @user.mobile_phone_verification_at = 10.minutes.ago
    @states = State.find_all_by_country_id(1)
    @cities = City.find_all_by_state_id(@user.state_id)

    respond_to do |format|
      if @user.valid?
        if @user.save_without_session_maintenance
          @user.deliver_welcome!
          flash[:warning] = "Sua senha foi enviada por e-mail!"

          format.html { redirect_to :login }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  def facebook_share_event()  
    if current_user.oauth_expires_at.nil?
      flash[:notice] = "Antes, conecte sua conta com seu Facebook para poder compartilhar."
      redirect_to user_path(current_user) + "/#t_tab2"
      return
    end

    begin
      event = Event.find(params[:event_id])
      already_ticket = Ticket.find(:all, :conditions => "origin='share_facebook' and event_id=" + event.id.to_s + " and user_id=" + current_user.id.to_s).count
      total_win = 1 - already_ticket

      if total_win > 0
        current_user.post_facebook(event_url(event))

        (1..total_win).each do
          current_user.ticket_add(params[:event_id], "share_facebook")
        end
        
        flash[:success] = "Voce ganhou um ticket! Nao se esqueca de numera-lo e dar checkout nele!"
      else
        flash[:notice] = "Opa! Voce ja ganhou este ticket. Tente outro."
      end      
    rescue => ex
      flash[:error] = ex.message 
      logger.error ex.message
    end
    redirect_to root_path
  end

  def twitter_share_event()  
    if current_user.twitter_oauth_expires_at.nil?
      flash[:notice] = "Antes, conecte sua conta com seu Twitter para poder compartilhar."
      redirect_to user_path(current_user) + "/#t_tab2"
      return
    end

    begin
      event = Event.find(params[:event_id])
      already_ticket = Ticket.find(:all, :conditions => "origin='share_twitter' and event_id=" + event.id.to_s + " and user_id=" + current_user.id.to_s).count
      total_win = 1 - already_ticket

      if total_win > 0
        current_user.post_twitter("Acabou de entrar no evento: " + event_url(event))
        
        (1..total_win).each do
          current_user.ticket_add(params[:event_id], "share_twitter")
        end
        
        flash[:success] = "Voce ganhou um ticket! Nao se esqueca de numera-lo e dar checkout nele!"
      else
        flash[:notice] = "Opa! Voce ja ganhou este ticket. Tente outro."
      end      
    rescue => ex
      flash[:error] = ex.message 
      logger.error ex.message
    end
    redirect_to root_path
  end
  
  def valid_mobile
    @user = User.find(params[:id])
    redirect_to user_path(@user) if @user.valid_mobile_phone
  end
  def valid_mobile_later_on
    session[:valid_mobile_later_on] = true
    redirect_to root_path    
  end
  
  def set_mobile
    @user = User.find(params[:id])
    respond_to do |format|
      
      if (@user.mobile_phone_number.to_s != params[:user][:mobile_phone_number].to_s) and (@user.update_attributes(:mobile_phone_number =>  params[:user][:mobile_phone_number]))
        clickatell_send
        format.html { redirect_to valid_mobile_user_path(@user), notice: 'Alteração realizada. Favor validar seu número de celular.' }
        format.json { head :no_content }
      else
        format.html { render action: "valid_mobile" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def send_mobile_phone_verification
    @user = current_user
    
    if clickatell_send
      flash[:notice] = "Em alguns minutos você receberá um SMS, favor aguardar."
    else
      flash[:error] = "Número de telefone inválido. Qualquer dúvida entre em contato."
    end
    redirect_to valid_mobile_user_path(@user)
  end
  def clickatell_send
    @user = User.find(params[:id])
    # sleep 5
    begin
      result = @user.send_sms_mobile_phone_code
      flash[:notice] = "Em alguns minutos você receberá um SMS, favor aguardar."
      true
    rescue Clickatell::API::Error => e
      flash[:error] = "Número de telefone inválido. Qualquer dúvida entre em contato."
      false
      # flash[:error] = "Clickatell API error: #{e.message}"
      # raise ArgumentError, e.message
    end
  end
  
  def mobile_phone_verification
    @user = current_user
    verification_code = params[:verification_code].to_s
    if verification_code == @user.mobile_phone_verification_code
      @user.set_valid_mobile_phone(true)
      @user.save
      flash.now[:success] = "Número de celular confirmado."
      redirect_to user_path(@user) + "/#t_tab1"
      true
    else
      flash[:error] = "Código errado. Tente novamente."
      redirect_to valid_mobile_user_path(@user)
      false
    end
  end
  
end

