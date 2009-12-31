require File.dirname(__FILE__) + '/../spec_helper'

describe DayOfAction do


  describe "on creation" do

    it "should complain of created without a scheduler" do
      creation = lambda { DayOfAction.create!(:date => Date.new, :time_zone => "Canberra")}
      creation.should raise_error("You must provide a scheduler to create a Day of Action")
    end

    it "should complain of created without a date" do
      creation = lambda { DayOfAction.create!(:scheduler => mock("scheduler"), :time_zone => "Canberra")}
      creation.should raise_error("You must provide a date to create a Day of Action")
    end

    it "should complain of created without a time zone" do
      creation =lambda { DayOfAction.create!(:scheduler => mock("scheduler"), :date => Date.new)}
      creation.should raise_error("You must provide a time zone to create a Day of Action")
    end

    it "should create a roster of slots for each time in schedule" do

      scheduler = mock("scheduler")
      date = mock("date")
      time_zone = mock("zone")
      time_for_slot_one = mock("time one")
      time_for_slot_two = mock("time two")
      time_slot_one = TimeSlot.new
      time_slot_two = TimeSlot.new


      scheduler.should_receive(:each_time_slot_in).with(date, time_zone).and_yield(time_for_slot_one).and_yield(time_for_slot_two)
      TimeSlot.should_receive(:create!).with(:start_time => time_for_slot_one).and_return(time_slot_one)
      TimeSlot.should_receive(:create!).with(:start_time => time_for_slot_two).and_return(time_slot_two)

      day_of_action = DayOfAction.create!(:scheduler => scheduler, :date => date, :time_zone => time_zone)
      day_of_action.time_slots.should eql([time_slot_one, time_slot_two])
    end

  end
end
