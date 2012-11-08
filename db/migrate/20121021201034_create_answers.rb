class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text
      t.string :description
      t.integer :position
      t.integer :iscorrect
      t.integer :question_id
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
