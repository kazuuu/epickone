class EventsController < ApplicationController
  before_filter :require_user,  :only => [:join_questions, :questions_check, :pick_a_number, :add_cart, :results]

  require 'will_paginate/array'

  #before_filter :require_user
  #before_filter :require_user_admin,  :except => [:join_promo, :join_paid, :join_questions, :questions_check, :pick_a_number, :pick_a_number_promo, :show, :add_cart ]
  
  # GET /events
  # GET /events.json
  def index
    @events = Events.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id], :joins => :category)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end


  def join_questions
    @event = Event.find(params[:id])
  end

  def questions_check
    @event = Event.find(params[:id])
    @bOk = true;
    
    @event.questions.each do |question|
      @ans = question.answers.find(:all, :conditions => 'iscorrect = 1')

      if !@ans.empty?
        if params[question.id.to_s].nil? || params[question.id.to_s][:answer] != @ans[0]['id'].to_s
          if @bOk == true
            @bOk = false
          end
        end
      else
        @bOk = false
      end
    end
    if @bOk
      redirect_to pick_a_number_event_path
    end    
  end

  def pick_a_number
    session[:event_id] = params[:id]
    @event = Event.find(params[:id])
    @tickets_already = current_user.tickets.find(:all, :joins => :cart, :conditions => 'carts.purchased_at is not null and event_id=' + @event.id.to_s, :order => "picked_number ASC")
    @numbers = (1..1000).to_a.paginate(page: params[:page], :per_page => 100)
    @tickets = current_cart.tickets.find(:all, :conditions => 'event_id = ' + params[:id])
  end
  def add_cart
    @ticket = Ticket.find(params[:id])
    
    if @event.join_type == 'questions'      
      @new_cart = current_user.carts.build()
      @new_cart.purchased_at = Time.now
      @new_cart.save

      @ticket = @new_cart.tickets.build(:event_id => params[:id])
      @ticket.user_id = current_user.id
      @ticket.quantity = 1
      @ticket.unit_price = 0
      @ticket.picked_number = params[:number]
      @ticket.save

      flash[:success] = "Congratulations! You've joined."
      redirect_to pick_a_number_event_path        
    elsif @event.join_type == 'paid'
      @ticket = current_cart.ticket.build(:event_id => params[:id])
      @ticket.user_id = current_user.id
      @ticket.quantity = 1
      @ticket.unit_price = @event.price_ticket
      @ticket.picked_number = params[:number]

      if @ticket.save
        redirect_to pick_a_number_event_path
        session[:cart_count] = current_cart.tickets.count
      else
        flash[:notice] = "error!."
        redirect_to pick_a_number_event_path
      end
    else
      raise "event.join_type is missing"
    end
  end    
  def results
    @event = Event.find(params[:id])
    @max_number = @event.tickets.maximum(:picked_number)
    @numbers = (1..@max_number)
  end
end
