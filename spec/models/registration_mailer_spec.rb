require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationMailer do

  before do
    ActionMailer::Base.deliveries = []
    @registration = mock("registration")
    @time_slot = mock("timeslot")
    @time_slot.stub!(:start_time).and_return(Time.now)
    @day_of_action = mock("day of action")
    @day_of_action.stub!(:date).and_return(Date.today)
    @day_of_action.stub!(:recipient).and_return("recipent")
    @day_of_action.stub!(:phone).and_return("phone")
    @day_of_action.stub!(:subject).and_return("subject")
    @registration.stub!(:email_address).and_return("foo@bar.com")
    @registration.stub!(:time_slot).and_return(@time_slot)
    @registration.stub!(:day_of_action).and_return(@day_of_action)
  end

  it "should send mail to registration email address" do
    @registration.should_receive(:email_address).and_return("foo@bar.com")
    RegistrationMailer.deliver_confirmation_email(@registration)
    ActionMailer::Base.deliveries.size.should == 1
    email = ActionMailer::Base.deliveries[0]
    email.to.should eql ["foo@bar.com"]
  end

  it "should send mail from EFA" do
    RegistrationMailer.deliver_confirmation_email(@registration)
    ActionMailer::Base.deliveries.size.should == 1
    email = ActionMailer::Base.deliveries[0]
    email.from.should eql ["what@should.this.be.com"]
  end

  it "should send mail with subject containing important details" do
    nine_am_on_30_july_1975 = DateTime.civil(1975,7,30,9,0)
    @time_slot.should_receive(:start_time).and_return(nine_am_on_30_july_1975)
    @day_of_action.should_receive(:recipient).and_return("Kevin Rudd's Office")
    RegistrationMailer.deliver_confirmation_email(@registration)
    ActionMailer::Base.deliveries.size.should == 1
    email = ActionMailer::Base.deliveries[0]
    email.subject.should eql "You're registered to call Kevin Rudd's Office at 09:00 AM on 30/07/1975"
  end

  it "should send mail with body containing all details" do
    nine_am_on_30_july_1975 = DateTime.civil(1975,7,30,9,0)
    @time_slot.stub!(:start_time).and_return(nine_am_on_30_july_1975)
    @day_of_action.stub!(:recipient).and_return("Kevin Rudd's Office")
    @day_of_action.stub!(:phone).and_return("(02) 5555 5555")
    @day_of_action.stub!(:subject).and_return("The Internet Filter")
    RegistrationMailer.deliver_confirmation_email(@registration)
    ActionMailer::Base.deliveries.size.should == 1
    email = ActionMailer::Base.deliveries[0]
    email.body.should =~ /Kevin Rudd's Office/
    email.body.should =~ /09:00 AM on Wednesday 30th July 1975/
    email.body.should =~ /\(02\) 5555 5555/
    email.body.should =~ /The Internet Filter/
  end

  # tell them what timezone we are talking
  # deal with timezone properly
  
  #do we need to set the sent time?

end
