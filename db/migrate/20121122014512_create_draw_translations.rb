class CreateDrawTranslations < ActiveRecord::Migration
  def up
    Draw.create_translation_table!({
      title: :string,
      headline: :string,
      description: :text,
      instruction: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Draw.drop_translation_table! migrate_data: true
  end
end
