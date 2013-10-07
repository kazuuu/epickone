class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      
      t.string :document
      t.string :gender
      t.integer :city_id
      t.integer :state_id
      t.integer :country_id
      t.string :address1
      t.string :address2
      t.string :postcode
      t.date :birthday
      t.string :mobile_phone_number

      t.has_attached_file :avatar
      t.boolean :active, :default => false, :null => false         
      t.boolean :admin_flag, :default => false
      t.boolean :email_confirmed, :default => false, :null => false         
      t.boolean :newsletter, :default => true
      t.string :current_login_ip

      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token, :default => "", :null => false   

      t.string   :provider    
      t.string  :oauth_token
      t.datetime :oauth_expires_at
      t.string  :facebook_uid
      t.string :twitter_uid
      t.string :twitter_oauth_token
      t.string :twitter_oauth_secret
      t.datetime :twitter_oauth_expires_at
      
      t.timestamps
    end
    add_index :users, :perishable_token, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :mobile_phone_number, :unique => true
  end
end
