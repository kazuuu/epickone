class CitiesController < ApplicationController
  def index 
    @cities = City.order(:name).where("upper(name) like upper(?)", "#{params[:term]}%")
    render json: @cities.map {|model| "#{model.name}, #{model.state.name_code}"}
  end
end
