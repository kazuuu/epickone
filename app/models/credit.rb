class Credit < ActiveRecord::Base
  attr_accessible :comment, :user_id, :value
  belongs_to :user
end
