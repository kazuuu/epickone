class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    @draws = Draw.find(:all, :conditions => "join_type='paid'", :order => "date_due asc")
#    @draws = @draws.paginate(page: params[:page]) if @draws.count > 0 # willpaginate 
    
    @promo_draws = Draw.find(:all, :conditions => "site_position='main_banner'", :order => "date_due asc")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end      
  end

  def help
  end

  def how_to_win
  end

  def about
  end

  def contact
  end
end
