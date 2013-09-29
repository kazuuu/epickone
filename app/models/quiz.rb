class Quiz < ActiveRecord::Base
  attr_accessible :title
  has_many :events
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true   
  
  validates_presence_of :title
end
