class Email < ActiveRecord::Base
  attr_accessible :email, :token, :user_id, :valid_email

  validates_presence_of :email,
                        :user_id

  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  belongs_to :user

  before_save :token_generate  
  before_save :email_uniqueness  

  default_scope order: 'valid_email desc'
  
  def email_uniqueness
    e = User.find(:all, :conditions => ["lower(email) = lower(?)", email])
    if e.count > 0
      self.errors.add(:email, "Este e-mail já está em uso.")
      false
    else
      true
    end
  end
  def token_generate
    self.token = Digest::SHA1.hexdigest Time.now.to_s
  end
  def activate!
    self.valid_email = true
    save
  end
  def deliver_activation!
    Notifier.email_activation(self).deliver
  end
end
