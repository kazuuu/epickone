class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :draw_id
      t.integer :user_id
      t.decimal :value
      t.string :credit_type
      t.string :comment
      t.boolean :is_used, :default => false, :null => false   
      t.datetime :used_at

      t.timestamps
    end
  end
end
