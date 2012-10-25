class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.integer :order
      t.integer :type
      t.integer :draw_id

      t.timestamps
    end
  end
end
