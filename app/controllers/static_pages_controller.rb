class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @title = "home"
    @user = User.new

    # @man = Event.find(:all, :limit => 1, :joins => :category, :conditions => "categories.site_position = 'man'", :order => "date_due asc") 
    # @woman = Event.find(:all, :limit => 1, :joins => :category, :conditions => "categories.site_position = 'woman'", :order => "date_due asc") 

    @events_outros1 =  Event.find(:all, :conditions => ["category_id = 1 and date(date_start) <= ? and date(date_due) >= ?", Time.now, Time.now], :order => "date_due asc") 
    @events_outros2 =  Event.find(:all, :conditions => ["category_id = 2 and date(date_start) <= ? and date(date_due) >= ?", Time.now, Time.now], :order => "date_due asc") 
    @events_promo = Event.find(:all, :conditions => ["category_id = 3 and date(date_start) <= ? and date(date_due) >= ?", Time.now, Time.now], :order => "date_due asc") 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end      
  end

  def help
    @title = "help"
  end
  def faq
    @title = "faq"
  end
  def privacy
    @title = "privacy"
    render :layout => false
  end
  def term
    @title = "term"
    render :layout => false
  end

  def how_it_works
    @title = "How it works"
  end

  def about
    @title = "about"
  end

  def contact
    @title = "contact"
  end  

  def msgbox
    @title = "Message Box"
    render :layout => false
  end  
end
