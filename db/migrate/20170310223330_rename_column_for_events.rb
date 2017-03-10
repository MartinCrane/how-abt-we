class RenameColumnForEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :date, :event_date
  end
end
