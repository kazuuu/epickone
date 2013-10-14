class EmailsController < ApplicationController
  def index
    @user = current_user
    
    render :layout => false    
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
end
