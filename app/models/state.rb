class State < ActiveRecord::Base
  attr_accessible :code_area, :country_id, :name, :code_alpha2
  belongs_to :country
end
