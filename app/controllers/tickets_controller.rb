class TicketsController < InheritedResources::Base
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
#    redirect_to checkout_cart_path(:id => session[:event_id])
    redirect_to checkout_cart_path(current_cart)
  end
  def add_number
    @ticket = Ticket.find(params[:id])
    @ticket.add_number(params[:number])
    redirect_to user_path(current_user) + '/#t_tab3'
  end
end
