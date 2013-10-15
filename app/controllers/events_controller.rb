class EventsController < ApplicationController
  before_filter :require_user,  :only => [:join_questions, :right_answer_check, :pick_a_number, :add_cart, :results, :quiz]
  before_filter :require_user_admin,  :only => [:results]

  require 'will_paginate/array'

  #before_filter :require_user
  #before_filter :require_user_admin,  :except => [:join_promo, :join_paid, :join_questions, :right_answer_check, :pick_a_number, :pick_a_number_promo, :show, :add_cart ]
  
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
    if !current_user.valid_mobile_phone
      flash[:error] = "Para participar é necessário ter um número de celular confirmado. Favor confirmar."
      redirect_to user_path(current_user.id) + "/#t_tab1"
    end
      
    @event = Event.find(params[:id])
    session[:question_number] = 1 if session[:question_number].nil?
    @question = @event.quiz.questions.find_by_sort_order(session[:question_number])
  end

  def right_answer_check
    event = Event.find(params[:id])
    q = event.quiz.questions.find_by_sort_order(session[:question_number])
    
    if params[q.id.to_s].nil?
      flash[:notice] = "Selecione a resposta que você acha correta."
      redirect_to quiz_event_path(params[:id])
    else
      
      if q.right_answer_check(params[q.id.to_s][:answer].to_i)
        if session[:question_number] < event.quiz.questions.count
          session[:question_number] = session[:question_number] + 1
          redirect_to quiz_event_path(params[:id])
        else
          session.delete(:question_number)
          if current_cart.ticket_add(params[:id], "answered")
            flash[:msgbox] = "Parabens! Voce ganhou um ticket. Mas voce precisa numera-lo para poder validar!"
            redirect_to user_path(current_user.id) + "/#t_tab3"
          else
            flash[:msgbox] = "Você já ganhou este ticket."
            redirect_to quiz_event_path(params[:id])
          end
        end
      else
        session.delete(:question_number)
        flash[:msgbox] = "Resposta errada. Comece do inicio novamente"
        redirect_to quiz_event_path(params[:id])
      end    
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
