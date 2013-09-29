class Ticket < ActiveRecord::Base
  attr_accessible :cart_id, 
                  :event_id,
                  :picked_number,
                  :origin
  #belongs_to :cart
  belongs_to :event
  belongs_to :cart 

  validates_presence_of :origin,
                        :cart_id,
                        :event_id
                        
  def add_number(number)
      update_attribute(:picked_number, number)
  end
end
