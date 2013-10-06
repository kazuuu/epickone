class City < ActiveRecord::Base
  attr_accessible :id, :phone_code, :name, :state_id
  
  validates_presence_of :name,
                        :state_id,
                        :phone_code
  
  belongs_to :state
end
