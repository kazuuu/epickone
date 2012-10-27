class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.string :description
      t.integer :order
      t.integer :iscorrect
      t.integer :question_id
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
