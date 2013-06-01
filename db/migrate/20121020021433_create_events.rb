class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :category_id
      t.integer :quiz_id
      t.string :title
      t.string :headline
      t.string :prize      
      t.string :site_position
      t.text :description
      t.text :instruction
      t.integer :join_min
      t.integer :join_max
      t.boolean :enable
      t.string :covering_area
      t.string :join_type
      t.decimal :price_ticket
      t.datetime :date_start
      t.datetime :date_due
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :events, [:category_id, :created_at]
  end
end
