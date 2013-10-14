class Email < ActiveRecord::Base
  attr_accessible :email, :token, :user_id, :valid_email

  validates_presence_of :email,
                        :user_id

  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  belongs_to :user

  before_save :token_generate  
  
  def token_generate
    self.token = Digest::SHA1.hexdigest Time.now.to_s
  end
end
