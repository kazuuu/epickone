class Draw < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :user
  
  validates :user_id, presence: true  
  validates :title, :length => { :maximum => 25 }
  validates :description, presence: true

  default_scope order: 'draws.created_at DESC'
  
end
