class StaticPagesController < ApplicationController
  def home
    unless params[:locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
#      redirect_to eval("root_#{I18n.locale}_path")
    end
    @title = "home"
    @user = User.new

    @events_promo = Event.find_running.find_enabled.find_all_by_category_id(1)
  end

  def help
    @title = "help"
  end
  def faq
    @title = "faq"
  end
  def privacy
    @title = "Política de Privacidade"
    render :layout => false
  end
  def term
    @title = "Termo de Uso"
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
