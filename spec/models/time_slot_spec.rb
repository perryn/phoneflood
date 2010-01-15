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

end
