class TicketsController < InheritedResources::Base
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    session[:cart_count] = current_cart.tickets.count
    redirect_to pick_a_number_event_path(:id => session[:event_id])
  end
end
