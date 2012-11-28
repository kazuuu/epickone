class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @user = User.new
    
     
    @draws_promos = Draw.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'first_line'", :order => "date_due asc") 
    @draws_eletronics = Draw.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'second_line'", :order => "date_due asc") 
    @draws_purses = Draw.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'third_line'", :order => "date_due asc") 
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
