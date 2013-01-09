class TicketsController < InheritedResources::Base
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to checkout_cart_path(:id => session[:event_id])
  end
end
