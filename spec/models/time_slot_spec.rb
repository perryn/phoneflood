require File.dirname(__FILE__) + '/../spec_helper'

describe TimeSlot do

  it "should start in free status" do
    time_slot = TimeSlot.create!()
    time_slot.status.should eql("free")
  end
  
  it "should be taken if it has a registration" do
    time_slot = TimeSlot.create!()
    time_slot.registration = Registration.new
    time_slot.status.should eql("taken")
  end
end
