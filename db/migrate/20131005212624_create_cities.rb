class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :state_id
      t.integer :phone_code

      t.timestamps
    end
  end
end
