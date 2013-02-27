class TicketsController < InheritedResources::Base
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
#    redirect_to checkout_cart_path(:id => session[:event_id])
    redirect_to checkout_cart_path(current_cart)
  end
end
