class CreateClients < ActiveRecord::Migration[7.0]
  def self.up
    create_table :clients do |t|
      t.text "name", :null => false
      t.string "email", :null => false
      t.bigint "contact"
      t.timestamps
    end

    add_index :clients, :email, unique: true
    add_index :clients, :contact, unique: true
  end

  def self.down
    drop_table :clients
  end
end
