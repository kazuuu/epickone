class UsersController < ApplicationController
  before_filter :require_no_user,  :only => [:new]
  before_filter :correct_user,  :only => [:show, :edit, :update]
  before_filter :require_user_admin,  :only => [:index]
  
  def facebook_share_draw()  
    begin
      draw = Draw.find(params[:draw_id])
      current_user.post_join(current_user.id, draw_url(draw))
    rescue => ex
      flash[:notice] = "TESTE Log " + ex.message 
      logger.error "TESTE Log " + ex.message
    end
    
    credit = current_user.credits.build(:draw_id => params[:draw_id])
    credit.comment = "facebook_share_draw"
    credit.value = 1
    credit.credit_type = "free"
    credit.save    

    redirect_to root_path
  end
  
  def wincredits
    @user = current_user
    @user.free_credits_load
  end

  def credits
    @user = current_user
    @user.free_credits_load
  end
  
  # GET /users
  # GET /users.json
  def index
    # @users = User.all # Authlogic
    @users = User.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    # @draws = @user.draws.paginate(page: params[:page])

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
      if @user.save
        format.html { redirect_to @user, notice: 'Registration successfull.' }
        format.json { render json: @user, status: :created, location: @user }
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
