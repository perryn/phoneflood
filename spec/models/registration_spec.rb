require File.dirname(__FILE__) + '/../spec_helper'

describe Registration do

  describe "on creation" do

    it "should considered invalid without a timeslot" do
      reg = Registration.create()
      reg.errors.on(:time_slot_id).should eql(" - please choose a time")
    end

    it "should considered invalid without an email, but should only give one error message" do
      reg = Registration.create()
      reg.errors.on(:email_address).should eql(" - please tell us your email address")
    end

    it "should considered invalid with an invalid email" do
      reg = Registration.create(:email_address => "notanemailaddress")
      reg.errors.on(:email_address).should eql(" - doesn't look like a real email address")
    end

  end
end
