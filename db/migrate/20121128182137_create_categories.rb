class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :title
      t.text :description
      t.integer :sort_order
      t.has_attached_file :avatar      
      t.string :join_type
      t.timestamps
    end
  end
end