class CartitemsController < InheritedResources::Base
  def destroy
    @cartitem = Cartitem.find(params[:id])
    @cartitem.destroy
    redirect_to pick_a_number_draw_path
  end
end
