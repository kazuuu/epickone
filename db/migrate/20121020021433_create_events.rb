class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :category_id
      t.integer :quiz_id
      t.string :title
      t.string :headline
      t.string :prize_title
      t.text :description
      t.text :instruction
      t.integer :join_min
      t.integer :join_max
      t.boolean :enable
      t.string :covering_area
      t.datetime :start_date
      t.datetime :end_date
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :events, :category_id
    add_index :events, :quiz_id
    add_index :events, :start_date
    add_index :events, :end_date
  end
end