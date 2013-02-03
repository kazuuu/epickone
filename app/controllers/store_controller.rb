class StoreController < ApplicationController
  def show
    @products = Product.paginate(page: params[:page]) # willpaginate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end
end
