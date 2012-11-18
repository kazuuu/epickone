class CreateDrawImages < ActiveRecord::Migration
  def change
    create_table :draw_images do |t|
      t.integer :draw_id
      t.string :image_type
      t.has_attached_file :image
      

      t.timestamps
    end
  end
end
