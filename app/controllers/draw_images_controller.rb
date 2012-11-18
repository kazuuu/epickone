class DrawImagesController < ApplicationController
  def new
    @draw_image = DrawImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @draw_image }
    end
  end

  def edit
    @draw_image = DrawImage.find(params[:id])
  end

  def create
    @draw_image = DrawImage.new(params[:user])      

    respond_to do |format|
      if @draw_image.save
        format.html { redirect_to @draw_image, notice: 'Registration successfull.' }
        format.json { render json: @draw_image, status: :created, location: @draw_image }
      else
        format.html { render action: "new" }
        format.json { render json: @draw_image.errors, status: :unprocessable_entity }
      end
    end
  end
end
