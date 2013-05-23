class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :quiz_id
      t.string :title
      t.text :description
      t.integer :order
      t.string :style
      t.string :question_type
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
