require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationsController do

  describe "on new" do

    before do
      @day_of_action = mock("DOA")
      @day_of_action.stub!(:time_zone).and_return("Foo")
      DayOfAction.stub!(:find).and_return(@day_of_action)
    end

    it "should find day of action and expose it to view" do
      DayOfAction.should_receive(:find).with("3").and_return(@day_of_action)
      get 'new', :days_of_action_id => 3

      response.should be_success
      assigns[:day_of_action].should equal(@day_of_action)
    end

    #so that vaildation errors from create can be displayed
    it "should expose registration set in flash to the view" do
      registration = mock("registration")
      flash[:registration] = registration
      get 'new', :days_of_action_id => 3
      assigns[:registration].should be(registration)
    end

    it "should set the time zone to the one specified by the day of action" do
      DayOfAction.should_receive(:find).with("3").and_return(@day_of_action)
      @day_of_action.should_receive(:time_zone).and_return("London")
      Time.should_receive(:zone=).with("London")
      get 'new', :days_of_action_id => 3
    end
  end

  describe "on create" do
    before do
      @registration = mock("registration")
      @registration.stub!(:valid?).and_return(true)
      Registration.stub!(:new).and_return(@registration)


      @time_slot = mock("Time Slot")
      @time_slot.stub!(:registration=)
      TimeSlot.stub!(:find).and_return(@time_slot)


    end

    it "should create a registration in the time slot" do
      Registration.should_receive(:new).with("time_slot_id" => "3", "foo"=> "bar").and_return(@registration)
      TimeSlot.should_receive(:find).with("3").and_return(@time_slot)
      @time_slot.should_receive(:registration=).with(@registration)
      post 'create', :registration => {:time_slot_id => "3", :foo => "bar"}
    end

    it "should redirect to new after successful create with flash flag set" do
      @registration.should_receive(:valid?).and_return(true)
      post 'create', :registration => {:time_slot_id => "3" }
      response.should redirect_to(:action => "new")
      flash[:thanks_for_registering].should_not be_nil
    end

    it "should redirect to new after failed create with flash model set" do
      @registration.should_receive(:valid?).and_return(false)
      post 'create', :registration => {:time_slot_id => "3" }
      response.should redirect_to(:action => "new")
      #so we can carry validation errors over the re-direct
      flash[:registration].should be(@registration)
      flash[:thanks_for_registering].should be_nil
    end
    
  end
end
