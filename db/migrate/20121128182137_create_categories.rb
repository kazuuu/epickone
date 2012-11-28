class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :site_position
      t.text :description
      t.integer :order
      t.timestamps
    end
  end
end
