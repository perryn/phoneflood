require File.dirname(__FILE__) + '/../spec_helper'

describe BusinessHoursScheduler do

  it "should yield times in 5 min increments from 9am to 5pm" do
    @scheduler = BusinessHoursScheduler.new
    
    date = Date.civil(1975,7,30)
    nine_am = DateTime.civil(1975,7,30,9,0)
    five_past_nine = DateTime.civil(1975,7,30,9,5)
    ten_past_nine = DateTime.civil(1975,7,30,9,10)
    five_to_five_pm = DateTime.civil(1975,7,30,16,55)
    five_pm = DateTime.civil(1975,7,30,17,0)
   
    generated_times = []
    @scheduler.each_time_slot_in(date, "UTC") do | time |
      generated_times << time
    end
    
    generated_times.size.should eql(96)
    generated_times.first.should eql(nine_am)
    generated_times.second.should eql(five_past_nine)
    generated_times.third.should eql(ten_past_nine)
    generated_times.last.should eql(five_to_five_pm)
    generated_times.should_not include(five_pm)
    
  end
  
  it "should handle starting time in a different time zone" do
    @scheduler = BusinessHoursScheduler.new
    
    date = Date.civil(1975,7,30)

    nine_am_in_perth = DateTime.civil(1975,7,30,9,0,0,"+800")
    
    generated_times = []
    @scheduler.each_time_slot_in(date, "Perth") do | time |
      generated_times << time
    end

    generated_times.first.should eql(nine_am_in_perth)
    
  end
  
  
  #TODO - check works equally well given a DateTime
  #how to tomezones affect this?
end
