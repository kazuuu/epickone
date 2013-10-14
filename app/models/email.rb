class Email < ActiveRecord::Base
  attr_accessible :email, :token, :user_id, :valid_email

  validates_presence_of :email,
                        :token,  
                        :user_id

  validates_uniqueness_of :email, :case_sensitive => false

  belongs_to :user
  
  
                          
end
