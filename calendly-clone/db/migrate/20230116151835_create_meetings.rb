class CreateMeetings < ActiveRecord::Migration[7.0]
  def self.up
    create_table :meetings do |t|
      t.string "meeting_id" , :null => false, :unique => true
      t.integer "agent_id" , :null => false 
      t.integer "client_id" , :null => false
      t.boolean "approved" , :default => false
      t.integer "cost" 
      t.date "date" , :null => false
      t.time "time" , :null => false
      t.timestamps
    end
    add_foreign_key :meetings, :agents, column: :agent_id
    add_foreign_key :meetings, :clients, column: :client_id
    add_index :meetings, :meeting_id, unique: true 
  end

  def self.down
    drop_table :meetings
  end
end
