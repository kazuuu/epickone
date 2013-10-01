class CartsController < ApplicationController

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to pick_a_number_event_path
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
  
  # GET /events
  # GET /events.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /events/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end
  # PUT /events/1
  # PUT /events/1.json
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
  def payment_not_needed
    @cart = Cart.find(params[:id])
    
    respond_to do |format|
      if @cart.update_attribute(:purchased_at, Time.now)
        format.html { redirect_to root_path, notice: 'Successful.' }
        format.json { head :no_content }
      else
        format.html { render action: "payment_not_needed" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end  
  def checkout
    @cart = current_cart
  end  
  def add_tickets
    cart=current_cart
    (1..params[:quantity].to_i).each do |i| 
      cart.ticket_add(params[:event_id], params[:origin].to_s)
    end
    redirect_to checkout_cart_path
  end
  def pick_a_number
    @ticket = Ticket.find(params[:ticket_id])
    session[:event_id] = @ticket.event_id
    @event = Event.find(@ticket.event_id)
    @tickets_already = @event.tickets.find_by_user_id(current_user.id).find_by_validated
    
    @numbers = (1..1000).to_a.paginate(page: params[:page], :per_page => 100)
    @tickets = current_cart.tickets.find_by_event_id(@event.id)
    # render :layout => false

  end
  def add_ticket_number
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.add_number(params[:number].to_i)
    redirect_to checkout_cart_path(params[:id])
  end
end
