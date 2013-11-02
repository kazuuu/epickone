class TicketsController < InheritedResources::Base
  def add_number
    @ticket = Ticket.find(params[:id])
    @ticket.add_number(params[:number])
    redirect_to user_path(current_user) + '/#t_tab3'
  end
end
