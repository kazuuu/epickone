class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image_type
      t.has_attached_file :image      
      t.belongs_to :photable, polymorphic: true

      t.timestamps
    end
    add_index :photos, [:photable_id, :photable_type]
  end
end
