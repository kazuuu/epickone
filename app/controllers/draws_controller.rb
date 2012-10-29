class DrawsController < ApplicationController
  require 'will_paginate/array'

  before_filter :require_user
  before_filter :require_user_admin,  :except => [:join]
  
  # GET /draws
  # GET /draws.json
  def index
    #@draws = Draw.all
    @draws = Draw.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @draws }
    end
  end

  # GET /draws/1
  # GET /draws/1.json
  def show
    @draw = Draw.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @draw }
    end
  end

  # GET /draws/new
  # GET /draws/new.json
  def new
    @draw = Draw.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @draw }
    end
  end

  # GET /draws/1/edit
  def edit
    @draw = Draw.find(params[:id])
  end

  # POST /draws
  # POST /draws.json
  def create
    # @draw = Draw.new(params[:draw])    
 
    @draw = current_user.draws.build(params[:draw]) 

 
    respond_to do |format|
      if @draw.save
        format.html { redirect_to @draw, notice: 'Registration successfull.' }
        format.json { render json: @draw, status: :created, location: @draw }
      else
        format.html { render action: "new" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PUT /draws/1
  # PUT /draws/1.json
  def update
    @draw = Draw.find(params[:id])

    respond_to do |format|
      if @draw.update_attributes(params[:draw])
        format.html { redirect_to @draw, notice: 'Draw was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draws/1
  # DELETE /draws/1.json
  def destroy
    @draw = Draw.find(params[:id])
    @draw.destroy

    respond_to do |format|
      format.html { redirect_to draws_url }
      format.json { head :no_content }
    end
  end
  def join    
    @draw = Draw.find(params[:id])
    @m = @draw.drawships.build(:user_id => current_user.id)
    @m.picked_number = params[:number]
      if @m.save
        flash[:notice] = "You have joined!."
         redirect_to root_path
      else
        flash[:notice] = "error!."
         redirect_to pick_a_number_draw_path
      end
  end  

  def join_questions
    @draw = Draw.find(params[:id])
  end
  
  def questions_check
    @draw = Draw.find(params[:id])
    @bOk = true;
    
    @draw.questions.each do |question|
      @ans = question.answers.find(:all, :conditions => 'iscorrect = 1')

      if !@ans.empty?
        if params[question.id.to_s].nil? || params[question.id.to_s][:answer] != @ans[0]['id'].to_s
          if @bOk == true
            @bOk = false
          end
        end
      else
        @bOk = false
      end
    end
    if @bOk
      redirect_to pick_a_number_draw_path
    end    
  end

  def pick_a_number
    @numbers = (1..1000).to_a.paginate(page: params[:page], :per_page => 100)

    #@carts = current_user.carts.find(:all, :conditions => 'draw_id = ' + params[:id])
    if current_user.cart.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
      if !@cart.save
        flash[:error] = "error!."
        redirect_to root_path
      end
    else
      @cart = current_user.cart
    end
    #@cart.cartitems.find(:all, :conditions => 'draw_id = ' + params[:id])
  end
  def add_cart    
    @cartitem = current_user.cart.cartitems.build(:draw_id => params[:id])
    @cartitem.quantity = 1
    @cartitem.unit_price = 1.50
    @cartitem.picked_number = params[:number]
    if @cartitem.save
      redirect_to pick_a_number_draw_path
    else
      flash[:notice] = "error!."
      redirect_to pick_a_number_draw_path
    end
  end  
  def checkout
    @cart = current_user.cart
  end   
  
end
