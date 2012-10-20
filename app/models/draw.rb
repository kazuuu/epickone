class Draw < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  belongs_to :user
  
  validates :title, :length => { :maximum => 25 }
end
