class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :instruction
      t.integer :min_users
      t.integer :max_users
      t.string :localization
      t.decimal :price
      t.datetime :date_due
      t.datetime :date_start
      t.has_attached_file :avatar

      t.timestamps
    end
    add_index :draws, [:user_id, :created_at]
  end
end
