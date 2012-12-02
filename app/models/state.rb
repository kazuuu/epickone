class State < ActiveRecord::Base
  attr_accessible :code_area, :country_id, :name
  belongs_to :country
end
