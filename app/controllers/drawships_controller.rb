class DrawshipsController < ApplicationController
  before_filter :require_user
  before_filter :require_user_admin


  # GET /drawships
  # GET /drawships.json
  def index
    @drawships = Drawship.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drawships }
    end
  end

  # GET /drawships/1
  # GET /drawships/1.json
  def show
    @drawship = Drawship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drawship }
    end
  end

  # GET /drawships/new
  # GET /drawships/new.json
  def new
    @drawship = Drawship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drawship }
    end
  end

  # GET /drawships/1/edit
  def edit
    @drawship = Drawship.find(params[:id])
  end

  # POST /drawships
  # POST /drawships.json
  def create
    @drawship = current_user.drawships.build(:draw_id => params[:id])
    
    
    if @drawship.save
      flash[:notice] = "You have joined this draw."
      redirect_to :back
    else
      flash[:error] = "Unable to join."
      redirect_to :back
    end
  end

  # PUT /drawships/1
  # PUT /drawships/1.json
  def update
    @drawship = Drawship.find(params[:id])

    respond_to do |format|
      if @drawship.update_attributes(params[:drawship])
        format.html { redirect_to @drawship, notice: 'Drawship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @drawship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drawships/1
  # DELETE /drawships/1.json
  def destroy
    @drawship = current_user.drawships.find(params[:id])
    @drawship.destroy
    flash[:notice] = "Removed membership."
    redirect_to :back
  end
end
