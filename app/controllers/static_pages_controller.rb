class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @title = "home"
    @user = User.new

    @events_social = Event.find_by_category_id(1).find_by_date_open
    @events_outros2 = Event.find_by_category_id(2).find_by_date_open
    @events_promo = Event.find_by_category_id(3).find_by_date_open
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
