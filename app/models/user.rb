class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
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
                  :phone_mobile
    has_many :draws 
  acts_as_authentic do |c| 
    c.login_field = :email 
  end 
end
