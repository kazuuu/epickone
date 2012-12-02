class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code_alpha2
      t.string :code_alpha3
      t.string :code_numeric
      t.string :code_language
      t.string :currency

      t.timestamps
    end
  end
end
