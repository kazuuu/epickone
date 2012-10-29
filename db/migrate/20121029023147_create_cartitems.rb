class CreateCartitems < ActiveRecord::Migration
  def change
    create_table :cartitems do |t|
      t.integer  :draw_id
      t.decimal  :unit_price
      t.integer  :quantity
      t.string   :comment
      t.integer  :cart_id
      t.integer  :picked_number

      t.timestamps
    end
  end
end
