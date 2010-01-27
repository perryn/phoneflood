require File.dirname(__FILE__) + '/../spec_helper'

describe TimeSlot do

  it "should start in free status and available" do
    time_slot = TimeSlot.create!()
    time_slot.status.should eql("free")
    time_slot.available?.should be_true
  end

  it "should be able to fill slot with a registration" do
    time_slot = TimeSlot.create!()
    registration = Registration.new
    time_slot.registration = registration
    time_slot.registration.should eql(registration)
  end

  it "should be taken if it has a registration" do
    time_slot = TimeSlot.create!()
    time_slot.registration = Registration.new
    time_slot.status.should eql("taken")
    time_slot.available?.should be_false
  end

  it "should not be able to fill slot if it already has a registration" do
    time_slot = TimeSlot.create!()
    registration_one = Registration.new
    registration_two = Registration.new
    time_slot.registration = registration_one
    lambda{time_slot.registration = registration_two}.should raise_error(TooSlowError)
  end
  
  it "should delegate strftime to the start_time having set the time zone from the day of action" do
    time_slot = TimeSlot.create!()
    
    day_of_action = mock("day of action")
    day_of_action.stub!(:time_zone).and_return("DOA Time Zone")
    start_time = mock("start_time")
    time_slot.stub!(:day_of_action).and_return(day_of_action)
    time_slot.stub!(:start_time).and_return(start_time)  
    start_time_in_time_zone = mock("start time in time zone")
    
    start_time.should_receive(:in_time_zone).with("DOA Time Zone").and_return(start_time_in_time_zone)
    start_time_in_time_zone.should_receive(:strftime).with("format").and_return("result")
    
    time_slot.strftime("format").should eql("result")
  end

end
