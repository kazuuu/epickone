class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :titlet
      t.string :description
      t.integer :order
      t.integer :iscorrect
      t.integer :question_id

      t.timestamps
    end
  end
end
