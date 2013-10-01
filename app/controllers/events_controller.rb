class EventsController < ApplicationController
  before_filter :require_user,  :only => [:join_questions, :quiz_result, :pick_a_number, :add_cart, :results, :quiz]
  before_filter :require_user_admin,  :only => [:results]

  require 'will_paginate/array'

  #before_filter :require_user
  #before_filter :require_user_admin,  :except => [:join_promo, :join_paid, :join_questions, :quiz_result, :pick_a_number, :pick_a_number_promo, :show, :add_cart ]
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id], :joins => :category)
    @quantity = ['1','2', '3', '4', '5', '6', '7', '8', '9', '10']
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def quiz
    @event = Event.find(params[:id])
    session[:question_number] = 1 if session[:question_number].nil?
    @question = @event.quiz.questions.find_by_sort_order(session[:question_number]).first
  end

  def quiz_result
    @event = Event.find(params[:id])
    question = @event.quiz.questions.find_by_sort_order(session[:question_number]).first
    answer = question.answers.find_right_answer.first
    
    if params[question.id.to_s][:answer].to_s == answer.id.to_s
      if session[:question_number] < @event.quiz.questions.count
        session[:question_number] = session[:question_number] + 1
        redirect_to quiz_event_path(params[:id])
      else
        origin = "answered"
        already_ticket = @event.tickets.find_by_user_id(current_user.id).find_by_origin("answered").count
        total_win = 1 - already_ticket
      
        if total_win > 0
          (1..total_win).each do
            current_cart.ticket_add(params[:id], origin)
          end
          flash[:msgbox] = "Parabens! Voce ganhou um ticket. Mas voce precisa numera-lo para poder validar!"
          session[:question_number] = nil
          redirect_to checkout_cart_path(current_cart)
        else
          flash[:msgbox] = "You have already won this ticket. Try to share this event to win more tickets."
          session[:question_number] = nil
          redirect_to event_path(params[:id])
        end
      end
    else
      flash[:msgbox] = "Algumas respostas estao erradas. E preciso acertar 100% para ganhar o ticket."
      redirect_to quiz_event_path(params[:id])
    end    
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
