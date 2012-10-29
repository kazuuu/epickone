class Drawship < ActiveRecord::Base
  attr_accessible :draw_id, :picked_number, :user_id, :cart_id, :comment
  belongs_to :draw
  belongs_to :user
end
