class AddDataToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :street_number, :integer
    add_column :locations, :road, :string
    add_column :locations, :state, :string
    add_column :locations, :city, :string
    add_column :locations, :country, :string
    add_column :locations, :formatted_address, :string
  end
end
