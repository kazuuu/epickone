class PhotosController < ApplicationController
   before_filter :load_photable

    def index
      @images = @photable.images
    end

    def new
    end

  private

    def load_photable
      resource, id = request.path.split('/')[1,2]
      @photable = resource.singularize.classify.constantize.find(id)
      
      # To personalize URL
      # klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"]}
      # @photable = klass.find(params["#{klass.name.underscore}_id"])
    end
end
