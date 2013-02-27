class UsersController < ApplicationController
  before_filter :require_no_user,  :only => [:new]
  before_filter :require_user,  :only => [:show, :edit, :update]
  before_filter :require_user_admin,  :only => [:index]

    
  def facebook_share_event()  
    if current_user.twitter_oauth_expires_at.nil?
      flash[:notice] = "Antes, conecte sua conta com seu Facebook para poder compartilhar."
      redirect_to user_path(current_user) + "#t_tab2"
      return
    end

    begin
      event = Event.find(params[:event_id])
      already_ticket = Ticket.find(:all, :conditions => "origin='share_facebook' and event_id=" + event.id.to_s + " and user_id=" + current_user.id.to_s).count
      total_win = 1 - already_ticket

      if total_win > 0
        # current_user.post_facebook(event_url(event))
        current_user.post_join(current_user.id, event_url(event))
        (1..total_win).each do
          current_cart.ticket_add(params[:event_id], "share_facebook")
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
      redirect_to user_path(current_user) + "#t_tab2"
      return
    end

    begin
      event = Event.find(params[:event_id])
      already_ticket = Ticket.find(:all, :conditions => "origin='share_twitter' and event_id=" + event.id.to_s + " and user_id=" + current_user.id.to_s).count
      total_win = 1 - already_ticket

      if total_win > 0
        current_user.post_twitter("Acabou de entrar no evento: " + event_url(event))
        (1..total_win).each do
          current_cart.ticket_add(params[:event_id], "share_twitter")
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
    # @events = @user.events.paginate(page: params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])      

    respond_to do |format|
      if @user.save_without_session_maintenance
        @user.deliver_activation!
        format.html { redirect_to root_path, notice: 'Your account has been created. Please check your e-mail for your account activation instructions!' }
        format.json { render json: root_path, status: :created, location: root_path }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
end

