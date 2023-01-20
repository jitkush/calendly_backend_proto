class CreateAgents < ActiveRecord::Migration[7.0]
  def self.up
    create_table :agents do |t|
      t.text "name", :null => false
      t.string "email", :null => false, :unique => true
      t.timestamps
    end
    add_index :agents, :email, unique: true
  end

  def self.down
    drop_table :agents
  end
end
