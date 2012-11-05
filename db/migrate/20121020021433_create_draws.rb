class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :instruction
      t.integer :join_min
      t.integer :join_max
      t.string :localization
      t.decimal :price_original
      t.datetime :date_due
      t.datetime :date_start
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :draws, [:user_id, :created_at]
  end
end
