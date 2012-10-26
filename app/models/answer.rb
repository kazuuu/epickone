class Answer < ActiveRecord::Base
  attr_accessible :description, :iscorrect, :order, :question_id, :title
  belongs_to :question
end
