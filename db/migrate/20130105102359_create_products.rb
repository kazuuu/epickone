class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.integer :category_id
      t.integer :order
      t.decimal :price_original
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
