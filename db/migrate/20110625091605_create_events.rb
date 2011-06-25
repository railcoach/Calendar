class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :description
      t.string :name
      t.string :homepage
      t.references :location

      t.timestamps
    end
    add_index :events, :location_id
  end
end
