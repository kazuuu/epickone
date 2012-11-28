class DrawsController < ApplicationController
  before_filter :require_user,  :only => [:join_questions, :questions_check, :pick_a_number, :add_cart, :results]

  require 'will_paginate/array'

  #before_filter :require_user
  #before_filter :require_user_admin,  :except => [:join_promo, :join_paid, :join_questions, :questions_check, :pick_a_number, :pick_a_number_promo, :show, :add_cart ]
  
  # GET /draws
  # GET /draws.json
  def index
    #@draws = Draw.all
    @draws = Draw.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @draws }
    end
  end

  # GET /draws/1
  # GET /draws/1.json
  def show
    @draw = Draw.find(params[:id], :joins => :category)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @draw }
    end
  end


  def join_questions
    @draw = Draw.find(params[:id])
  end

  def questions_check
    @draw = Draw.find(params[:id])
    @bOk = true;
    
    @draw.questions.each do |question|
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
      if current_user.total_credits(params[:id]) > 0
#        redirect_to pick_a_number_promo_draw_path
        redirect_to pick_a_number_draw_path
      else
        flash[:notice] = "You don't have free credits to join this draw. Maybe you have in another draw."
        redirect_to pick_a_number_draw_path
#        redirect_to wincredits_user_path
      end
      
    end    
  end

  def pick_a_number
    session[:draw_id] = params[:id]
    @draw = Draw.find(params[:id])
    @cartitems_already = current_user.cartitems.find(:all, :joins => :cart, :conditions => 'carts.purchased_at is not null and draw_id=' + @draw.id.to_s, :order => "picked_number ASC")
    @numbers = (1..1000).to_a.paginate(page: params[:page], :per_page => 100)
    @cartitems = current_cart.cartitems.find(:all, :conditions => 'draw_id = ' + params[:id])
  end
  def add_cart
    @draw = Draw.find(params[:id])
    
    if @draw.join_type == 'questions'      
      if current_user.total_credits(@draw.id.to_s) > 0 then
        @new_cart = current_user.carts.build()
        @new_cart.purchased_at = Time.now
        @new_cart.save

        @cartitem = @new_cart.cartitems.build(:draw_id => params[:id])
        @cartitem.user_id = current_user.id
        @cartitem.quantity = 1
        @cartitem.unit_price = 0
        @cartitem.picked_number = params[:number]
        @cartitem.save

        @credit = current_user.credits.find(:first, :conditions => "is_used = 'f' and draw_id =" + params[:id])
        @credit.update_attributes({
          :used_at => Time.now,
          :is_used => true
            })    
        flash[:success] = "Congratulations! You've joined."
        redirect_to pick_a_number_draw_path        
      else
        flash[:notice] = "You have no more free credits for this draw"
        redirect_to pick_a_number_draw_path        
      end
    elsif 'paid'
      @cartitem = current_cart.cartitems.build(:draw_id => params[:id])
      @cartitem.user_id = current_user.id
      @cartitem.quantity = 1
      @cartitem.unit_price = @draw.price_ticket
      @cartitem.picked_number = params[:number]

      if @cartitem.save
        redirect_to pick_a_number_draw_path
        session[:cart_count] = current_cart.cartitems.count
      else
        flash[:notice] = "error!."
        redirect_to pick_a_number_draw_path
      end
    end
  end    
  def results
    @draw = Draw.find(params[:id])
    @max_number = @draw.cartitems.maximum(:picked_number)
    @numbers = (1..@max_number)
  end
end
