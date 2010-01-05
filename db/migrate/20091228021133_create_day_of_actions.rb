class CreateDayOfActions < ActiveRecord::Migration
  def self.up
    create_table :day_of_actions do |t|
      t.date :date
      t.string :recipient
      t.string :phone
      t.string :subject
      t.string :time_zone
      t.timestamps
    end
  end

  def self.down
    drop_table :day_of_actions
  end
end
