class Ticket < ActiveRecord::Base
  attr_accessible :cart_id, :comment, :event_id, :picked_number, :quantity, :unit_price, :user_id
  #belongs_to :cart
  belongs_to :event
  belongs_to :user
  belongs_to :cart 

  def full_price
    unit_price * quantity
  end
  
end
