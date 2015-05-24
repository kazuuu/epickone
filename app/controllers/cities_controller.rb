class CitiesController < ApplicationController
  def index 
    c, s = I18n.transliterate(params[:term].to_s).split(",", 2)
    @cities = City.order(:name).where("upper(name) like upper(?)", "#{c}%")
    render json: @cities.map {|model| "#{model.name}, #{model.state.name_code}"}
  end
end
