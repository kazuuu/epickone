class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

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

      t.string  :facebook_uid
      t.string  :twitter_uid
      t.string  :avatar_url
      
            
      t.timestamps
    end
  end
end
