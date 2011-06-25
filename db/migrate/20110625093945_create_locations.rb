class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :town
      t.string :country
      t.string :zipcode
      t.references :event

      t.timestamps
    end

    add_index :locations, :event_id
  end
end
