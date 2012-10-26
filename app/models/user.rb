class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :password_salt, 
                  :persistence_token, 
                  :current_login_ip, 
                  :first_name, 
                  :last_name, 
                  :document_number,
                  :gender,
                  :birth_date,
                  :city,
                  :state,
                  :country,
                  :address1,
                  :address2,
                  :zipcode,
                  :phone_mobile,
                  :admin_flag,
                  :avatar,
                  :avatar_delete
  
  has_many :drawships, :dependent => :destroy
  has_many :draws, :through => :drawships
  
  has_many :draws                 
                  
  before_save :destroy_avatar?
  has_attached_file :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  acts_as_authentic do |c| 
    c.login_field = :email 
    c.require_password_confirmation = false
  end 
  
  
  def all_draws
    (self.draws + self.draw_owners).uniq
  end  
  def avatar_delete
    @avatar_delete ||= "0"
  end

  def avatar_delete=(value)
    @avatar_delete = value
  end

  private
    def destroy_avatar?
      self.avatar.clear if @avatar_delete == "1"
    end
end
