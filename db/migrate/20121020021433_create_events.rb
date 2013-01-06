class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :title
      t.string :headline
      t.string :site_position
      t.text :description
      t.text :instruction
      t.integer :join_min
      t.integer :join_max
      t.boolean :enable
      t.string :covering_area
      t.string :join_type
      t.decimal :price_ticket
      t.datetime :date_due
      t.datetime :date_start
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
    add_index :events, [:product_id]
  end
end
