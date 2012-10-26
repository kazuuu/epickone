class Question < ActiveRecord::Base
  attr_accessible :description, :draw_id, :order, :title, :type, :answers_attributes
  
  belongs_to :draw
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  
end
