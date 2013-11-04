class TicketsController < InheritedResources::Base
  skip_before_filter :require_all_tickets_validated, :only => [:edit, :update, :validation, :submit_it]
  before_filter :correct_user, :already_submitted?

  # PUT /users/1
  # PUT /users/1.json
  def update
    @ticket = Ticket.find(params[:id])
    @possible_numbers = @ticket.generate_picked_number(5)

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to validation_user_ticket_path(current_user, @ticket) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    @possible_numbers = @ticket.generate_picked_number(5)
  end
  def validation
    @ticket = Ticket.find(params[:id])
  end
  def add_number
    @ticket = Ticket.find(params[:id])
    @ticket.add_number(params[:number])
    redirect_to user_path(current_user) + '/#t_tab3'
  end
  def submit_it
    @ticket = Ticket.find(params[:id])
    @ticket.submit_it
    redirect_to user_path(current_user) + '/#t_tab3'
  end
  
  protected  
  def already_submitted?
    @ticket = Ticket.find(params[:id])
    redirect_to user_path(current_user) + '/#t_tab3' unless @ticket.submitted_at.nil?
  end  
end
