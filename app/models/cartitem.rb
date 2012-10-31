class Cartitem < ActiveRecord::Base
  attr_accessible :cart_id, :comment, :draw_id, :picked_number, :quantity, :unit_price, :user_id
  belongs_to :cart
  belongs_to :draw
  def full_price
    unit_price * quantity
  end
  
end