class StaticPagesController < ApplicationController
  def home
    @user = User.new
    @draws = Draw.paginate(page: params[:page]) # willpaginate
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
