class Email < ActiveRecord::Base
  attr_accessible :email, :token, :user_id, :valid_email

  validates_presence_of :email,
                        :token,  
                        :user_id

  belongs_to :user
                          
end
