class CartitemsController < InheritedResources::Base
  def destroy
    @cartitem = Cartitem.find(params[:id])
    @cartitem.destroy
    session[:cart_count] = current_cart.cartitems.count
    redirect_to pick_a_number_draw_path(:id => session[:draw_id])
  end
end
