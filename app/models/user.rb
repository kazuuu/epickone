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
                  
    has_attached_file :avatar
    before_save :destroy_avatar?
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :draws, dependent: :destroy
  acts_as_authentic do |c| 
    c.login_field = :email 
    c.require_password_confirmation = false
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
