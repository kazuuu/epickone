class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :min_users
      t.string :max_users
      t.string :localization
      t.string :price
      t.string :date_due
      t.string :date_start

      t.timestamps
    end
    add_index :draws, [:user_id, :created_at]
  end
end
