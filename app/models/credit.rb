class Credit < ActiveRecord::Base
  attr_accessible :comment, :user_id, :value, :draw_id
  belongs_to :user
  belongs_to :draw
end
