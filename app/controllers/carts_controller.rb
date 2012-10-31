class CartsController < ApplicationController
  def checkout
    @cart = current_cart
  end   

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to pick_a_number_draw_path
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end
  
  def create
    @cart = current_user.carts.build(params[:cart]) 
    @cart.drawships.each do |i|
      i.user_id=current_user.id
      i.draw_id=params[:cart][:draw_id]
    end
 
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Registration successfull.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /draws
  # GET /draws.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /draws/1
  # GET /draws/1.json
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /draws/new
  # GET /draws/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /draws/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end
  # PUT /draws/1
  # PUT /draws/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  
end
