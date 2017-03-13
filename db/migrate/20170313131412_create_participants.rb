class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.integer :event_id
      t.integer :account_id

      t.timestamps
    end
  end
end
