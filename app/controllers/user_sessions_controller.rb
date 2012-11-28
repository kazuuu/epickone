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
    session[:cart_id] = nil
    session[:cart_count] = nil
    session[:free_credits] = nil
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        @user = User.find_by_email(@user_session.email)
        @user.free_credits_load
        format.html { redirect_to(root_path, :notice => 'Login Successful') }
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      elsif @user_session.attempted_record &&
          !@user_session.invalid_password? &&
          !@user_session.attempted_record.active?
          @user = User.find_by_email(@user_session.email)
          @user.deliver_activation!
          format.html { redirect_to(root_path, :notice => 'Sorry, before you can sign in you need to confirm your email address. We have just sent a confirmation again.') }
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
    session[:cart_id] = nil
    session[:cart_count] = nil
    session[:free_credits] = nil
    

    respond_to do |format|
      format.html { redirect_to(root_path, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end
end
