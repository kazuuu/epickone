class ToolsController < ApplicationController
  before_filter :require_user_admin

  def show
    @events = Event.find(:all)
  end
       

  def event_clone
    event_original = Event.find(params[:event_id])
    event_clone = Event.new
    event_clone.enable        = false
    event_clone.title         = event_original.title
    event_clone.category_id   = event_original.category_id
    event_clone.quiz_id       = event_original.quiz_id
    event_clone.headline      = event_original.headline
    event_clone.prize         = event_original.prize
    event_clone.site_position = event_original.site_position
    event_clone.description   = event_original.description
    event_clone.instruction   = event_original.instruction
    event_clone.join_min      = event_original.join_min
    event_clone.join_max      = event_original.join_max
    event_clone.covering_area = event_original.covering_area
    event_clone.join_type     = event_original.join_type
    event_clone.price_ticket  = event_original.price_ticket
    event_clone.date_due      = event_original.date_due
    event_clone.date_start    = event_original.date_start
    event_clone.avatar        = event_original.avatar
    
    if event_clone.save
     flash[:notice] = "Evento Clonado"
    else
     flash[:notice] = "Oops! Nao foi possivel clonar"
    end


    event_original.photos.find(:all).each do |event_photo| 
       photo_clone = event_clone.photos.build() 
       photo_clone.image_type = event_photo.image_type
       photo_clone.image = event_photo.image
       if photo_clone.save
         flash[:notice] << "Photo adicionada"
       else
         flash[:notice] << "OOps! Photo nao adicionada"
       end
    end
        
    redirect_to tools_path
  end
end
