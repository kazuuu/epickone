class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :title
      t.string :site_position
      t.text :description
      t.integer :order
      t.has_attached_file :avatar      
      t.timestamps
    end
  end
end
