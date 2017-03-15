class CreateFavoriteLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_locations do |t|
      t.integer :location_id
      t.integer :favorite_id
    end
  end
end
