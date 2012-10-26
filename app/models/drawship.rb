class Drawship < ActiveRecord::Base
  attr_accessible :draw_id, :picked_number, :user_id
  belongs_to :draws
  belongs_to :users
end
