class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @user = User.new
     
#    @events_first = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'second_row'", :order => "date_due asc") 
#    @events_second = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'first_row'", :order => "date_due asc") 
#    @events_third = Event.find(:all, :limit => 3, :joins => :category, :conditions => "categories.site_position = 'third_row'", :order => "date_due asc") 
#    @promo_events = Event.find(:all, :conditions => "site_position='main_banner'", :order => "date_due asc")

    @man = Event.find(:all, :limit => 1, :joins => :category, :conditions => "categories.site_position = 'man'", :order => "date_due asc") 
    @woman = Event.find(:all, :limit => 1, :joins => :category, :conditions => "categories.site_position = 'woman'", :order => "date_due asc") 
    @promo_events = Event.find(:all, :limit => 1, :joins => :category, :conditions => "categories.site_position = 'promo'", :order => "date_due asc") 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end      
  end

  def help
  end
  def faq
  end
  def privacy
  end
  def term
  end

  def how_it_works
    Twitter.update("I'm tweeting with @gem!")
  end

  def about
  end

  def contact
  end
end
