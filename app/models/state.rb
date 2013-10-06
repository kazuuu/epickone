class State < ActiveRecord::Base
  attr_accessible :id, :country_id, :name, :name_code
  
  validates_presence_of :name,
                        :name_code,
                        :country_id
  
  belongs_to :country
  has_many :cities
end
