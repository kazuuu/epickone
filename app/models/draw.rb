class Draw < ActiveRecord::Base
  attr_accessible :description, :title, :avatar, :min_users, :max_users, :localization, :price, :date_due, :date_start, :user_id, :questions_attributes
                  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :users
    
  has_many :drawships, :dependent => :destroy
  has_many :users, :through => :drawships
        
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true   
        
  validates :user_id, presence: true  
  validates :title, presence: true
  validates :title, :length => { :maximum => 25 }
  validates :description, presence: true

  validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  default_scope order: 'draws.created_at DESC'
end
