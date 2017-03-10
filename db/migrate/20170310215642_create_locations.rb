class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.decimal :latitude, :default => nil
      t.decimal :longitude, :default => nil

      t.timestamps
    end
  end
end
