class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :draw_id
      t.integer :user_id
      t.decimal :value
      t.string :credit_type
      t.string :comment

      t.timestamps
    end
  end
end
