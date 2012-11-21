class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.integer :user_id
      t.string :title
      t.string :headline
      t.string :site_position
      t.text :description
      t.text :instruction
      t.integer :join_min
      t.integer :join_max
      t.string :localization
      t.string :join_type
      t.decimal :price_original
      t.decimal :price_ticket
      t.datetime :date_due
      t.datetime :date_start
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :draws, [:user_id, :created_at]
  end
end
