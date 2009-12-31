class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :email_address
      t.references :time_slot
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
