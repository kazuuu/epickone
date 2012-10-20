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
      t.string :document_number
      t.string :gender
      t.datetime :birth_date
      t.string :city
      t.string :state
      t.string :country
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.string :phone_mobile
      t.boolean :admin_flag, :default => false
            
      t.timestamps
    end
  end
end
