class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :user_id
      t.string :email
      t.boolean :valid_email, :default => false, :null => false         
      t.string :token

      t.timestamps
    end
  end
end
