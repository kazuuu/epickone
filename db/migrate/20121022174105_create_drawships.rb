class CreateDrawships < ActiveRecord::Migration
  def change
    create_table :drawships do |t|
      t.integer :user_id
      t.integer :draw_id
      t.integer :cart_id
      t.integer :picked_number
      t.string :comment

      t.timestamps
    end
  end
end
