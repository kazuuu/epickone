class Answer < ActiveRecord::Base
  attr_accessible :description, :iscorrect, :order, :question_id, :titlet
end
