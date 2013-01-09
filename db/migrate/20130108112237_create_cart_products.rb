class CreateCartProducts < ActiveRecord::Migration
  def change
    create_table :cart_products do |t|
      t.integer :cart_id
      t.integer :user_id
      t.integer :product_id
      t.decimal :unit_price
      t.integer :quantity
      t.string :comment

      t.timestamps
    end
  end
end
