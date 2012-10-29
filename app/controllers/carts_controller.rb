class CartsController < InheritedResources::Base
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
end
