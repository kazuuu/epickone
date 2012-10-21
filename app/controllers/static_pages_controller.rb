class StaticPagesController < ApplicationController
  def home
    if current_user 
      redirect_to current_user
      return false    
    end
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end      
  end

  def help
  end

  def about
  end

  def contact
  end
end
