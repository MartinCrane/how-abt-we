class AddScoreToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :score, :integer, default: 0
  end
end
