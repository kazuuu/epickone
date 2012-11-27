class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @user = User.new
    
    @draws_medium_banner = Draw.find(:all, :conditions => "site_position='medium_banner'", :order => "date_due asc")
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
