class AddCapacityToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :capacity, :integer, default: 1
  end
end
