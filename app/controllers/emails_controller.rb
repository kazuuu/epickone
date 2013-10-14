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
  
end
