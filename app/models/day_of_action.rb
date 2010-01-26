class DayOfAction < ActiveRecord::Base
  attr_writer :scheduler 
  has_many :time_slots
  has_many :registrations, :through => :time_slots
  
  def before_create
    raise "You must provide a scheduler to create a Day of Action" unless @scheduler
    raise "You must provide a date to create a Day of Action" unless date
    raise "You must provide a time zone to create a Day of Action" unless time_zone
    @scheduler.each_time_slot_in(date, time_zone) do |time|
       time_slots << TimeSlot.create!(:start_time => time)
    end    
  end
  
  def send_reminders
    registrations.each do |registration|
      RegistrationMailer.deliver_reminder_email(registration)
    end
  end
  
  def self.test_create
    DayOfAction.create!(:date => Date.today, 
    :recipient => "Kevin Rudd's Office",
    :phone =>"(03) 9866 6789",
    :subject => "the internet filter",
    :scheduler => BusinessHoursScheduler.new,
    :time_zone => "Canberra")
  end
end
