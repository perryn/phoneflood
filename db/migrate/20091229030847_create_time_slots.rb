class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.datetime :start_time
      t.integer  :lock_version
      t.references :day_of_action
      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
  end
end
