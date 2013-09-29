class CreateEventsTranslations < ActiveRecord::Migration
  def up
    Event.create_translation_table!({
      title: :string,
      headline: :string,
      prize: :string,
      description: :text,
      instruction: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Event.drop_translation_table! migrate_data: true
  end
end