class DayOfAction < ActiveRecord::Base
  attr_writer :scheduler 
  has_many :time_slots
  
  def before_create
    raise "You must provide a scheduler to create a Day of Action" unless @scheduler
    raise "You must provide a date to create a Day of Action" unless date
    raise "You must provide a time zone to create a Day of Action" unless time_zone
    @scheduler.each_time_slot_in(date, time_zone) do |time|
       time_slots << TimeSlot.create!(:start_time => time)
    end    
  end
end
