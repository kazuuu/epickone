class Draw < ActiveRecord::Base
  attr_accessible :description, :title, :avatar
                  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :user
  
  validates :user_id, presence: true  
  validates :title, :length => { :maximum => 25 }
  validates :description, presence: true

  default_scope order: 'draws.created_at DESC'
  
end
