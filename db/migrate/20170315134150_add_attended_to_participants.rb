class AddAttendedToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :attended, :boolean
  end
end
