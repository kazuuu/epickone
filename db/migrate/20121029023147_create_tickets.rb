class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer  :user_id
      t.integer  :event_id
      t.integer  :picked_number
      t.string   :origin
      t.datetime  :validated_at

      t.timestamps
    end
  end
end
