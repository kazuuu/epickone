class CartProduct < ActiveRecord::Base
  attr_accessible :cart_id, :comment, :quantity, :unit_price, :user_id, :product_id

  belongs_to :product
  belongs_to :user
  belongs_to :cart 

  def full_price
    unit_price * quantity
  end
  
end
