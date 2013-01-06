class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @user = User.new
     
    @events_promos = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'first_line'", :order => "date_due asc") 
    @events_eletronics = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'second_line'", :order => "date_due asc") 
    @events_purses = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'third_line'", :order => "date_due asc") 




    @promo_events = Event.find(:all, :conditions => "site_position='main_banner'", :order => "date_due asc")
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
