class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :order
      t.string :style
      t.integer :draw_id
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
