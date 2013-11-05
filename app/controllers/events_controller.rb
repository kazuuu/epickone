class EventsController < ApplicationController
  before_filter :require_user,  :only => [:join_questions, :right_answer_check, :pick_a_number, :results, :quiz]
  before_filter :require_user_admin,  :only => [:results]

  require 'will_paginate/array'

  #before_filter :require_user
  
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
          flash[:success] = "Resposta correta. Continue assim!"
          redirect_to quiz_event_path(params[:id])
        else
          session.delete(:question_number)
          if current_user.ticket_add(params[:id], "answered")
            redirect_to user_path(current_user.id) + "/#t_tab3"
          else
            flash[:notice] = "Você já ganhou este ticket."
            redirect_to user_path(current_user.id) + "/#t_tab3"
          end
        end
      else
        session.delete(:question_number)
        session[:wrong_answer] = true
        redirect_to quiz_event_path(params[:id])
      end    
    end
  end
  
  def results
    @event = Event.find(params[:id])
    @max_number = @event.tickets.maximum(:picked_number)
    @numbers = (1..@max_number)
  end
end
