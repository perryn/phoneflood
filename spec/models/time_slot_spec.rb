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

  it "should format time in the day of action timezone" do

    time_slot = TimeSlot.create!()

    day_of_action = mock("day of action")
    day_of_action.stub!(:time_zone).and_return("Canberra")
    time_slot.stub!(:day_of_action).and_return(day_of_action)

    ten_pm_utc_on_30_july_1975 = DateTime.civil(1975,7,30,22,0) # in Canberra this is 8am on the 31st
    time_slot.stub!(:start_time).and_return(ten_pm_utc_on_30_july_1975)


    time_slot.strftime("%I %p").should eql("08 AM")
  end

  describe "the describe date method" do

    it "should decribe what date the timeslot is in in the day of action timezone" do
      time_slot = TimeSlot.create!()

      day_of_action = mock("day of action")
      day_of_action.stub!(:time_zone).and_return("Canberra")
      time_slot.stub!(:day_of_action).and_return(day_of_action)

      one_pm_utc_on_29_july_1975 = DateTime.civil(1975,7,29,13,0) # it will still be 29th in Canberra
      DateTime.stub!(:now).and_return(one_pm_utc_on_29_july_1975)
      ten_pm_utc_on_30_july_1975 = DateTime.civil(1975,7,30,22,0) # it will be the 31st in Canberra
      time_slot.stub!(:start_time).and_return(ten_pm_utc_on_30_july_1975)

      time_slot.describe_date.should eql ("on 31/07/1975")
    end

    it "should know about 'tomorrow' as a special case" do
      time_slot = TimeSlot.create!()

      day_of_action = mock("day of action")
      day_of_action.stub!(:time_zone).and_return("Canberra")
      time_slot.stub!(:day_of_action).and_return(day_of_action)

      eleven_pm_utc_on_29_july_1975 = DateTime.civil(1975,7,29,23,0) #this is the 30th in Canberra
      DateTime.stub!(:now).and_return(eleven_pm_utc_on_29_july_1975)
      ten_pm_utc_on_30_july_1975 = DateTime.civil(1975,7,30,22,0)  #it will be the 31st in Canberra
      time_slot.stub!(:start_time).and_return(ten_pm_utc_on_30_july_1975)

      time_slot.describe_date.should eql ("tomorrow")
    end

    it "should know about 'today' as a special case" do
      time_slot = TimeSlot.create!()

      day_of_action = mock("day of action")
      day_of_action.stub!(:time_zone).and_return("Canberra")
      time_slot.stub!(:day_of_action).and_return(day_of_action)

      eleven_pm_utc_on_30_july_1975 = DateTime.civil(1975,7,30,23,0) #this is the 31st in Canberra
      DateTime.stub!(:now).and_return(eleven_pm_utc_on_30_july_1975)
      nine_am_utc_on_31_july_1975 = DateTime.civil(1975,7,31,9,0)  #it will be the 31st in Canberra
      time_slot.stub!(:start_time).and_return(nine_am_utc_on_31_july_1975)

      time_slot.describe_date.should eql ("today")
    end

  end

end
