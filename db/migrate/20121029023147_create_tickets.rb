class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer  :event_id
      t.decimal  :unit_price
      t.integer  :quantity
      t.string   :origin
      t.integer  :cart_id
      t.integer  :user_id
      t.integer  :picked_number

      t.timestamps
    end
  end
end
