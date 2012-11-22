class CreateAnswersTranslations < ActiveRecord::Migration
  def up
    Answer.create_translation_table!({
      answer_text: :string,
      description: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Answer.drop_translation_table! migrate_data: true
  end
end
