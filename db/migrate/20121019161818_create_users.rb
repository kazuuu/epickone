class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token, :default => "", :null => false   
      t.boolean :active, :default => false, :null => false         
      t.string :current_login_ip

      t.string :first_name
      t.string :last_name
      t.string :document
      t.string :gender
      t.string :title
      t.datetime :birthday
      t.string :city
      t.string :state
      t.string :country
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.string :phone_mobile
      t.boolean :admin_flag, :default => false
      t.has_attached_file :avatar

      t.string  :locale
      t.string  :facebook_uid
      t.string  :oauth_token
      t.datetime :oauth_expires_at
      t.string   :provider    
      t.string  :avatar_url
      
            
      t.timestamps
    end
    add_index :users, [:perishable_token, :email]    
  end
end
