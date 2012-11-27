class Credit < ActiveRecord::Base
  attr_accessible :comment, :user_id, :value, :draw_id, :credit_type, :is_used, :used_at
  belongs_to :user
  belongs_to :draw
end
