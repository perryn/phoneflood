require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationsController do

  describe "on new" do

    before do
      @day_of_action = mock("DOA")
      DayOfAction.stub!(:find).and_return(@day_of_action)
    end

    it "should find day of action with eager loaded roster, and expose it to view" do
      DayOfAction.should_receive(:find).with("3", {:include=>{:time_slots=>:registration}}).and_return(@day_of_action)
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

    it "should redirect to new after successful create with message set" do
      @registration.should_receive(:valid?).and_return(true)
      post 'create', :registration => {:time_slot_id => "3" }
      response.should redirect_to(:action => "new")
      flash[:message].should_not be_nil
      flash[:too_slow].should be_nil
    end

    it "should redirect to new after failed create with flash model set" do
      @registration.should_receive(:valid?).and_return(false)
      post 'create', :registration => {:time_slot_id => "3" }
      response.should redirect_to(:action => "new")
      #so we can carry validation errors over the re-direct
      flash[:registration].should be(@registration)
      flash[:thanks_for_registering].should be_nil
      flash[:too_slow].should be_nil
    end

    it "should redirect to new with warning set if slot is unavailable" do
      @time_slot.should_receive(:registration=).and_raise(TooSlowError)
      post 'create', :registration => {:time_slot_id => "3" }
      response.should redirect_to(:action => "new")
      flash[:thanks_for_registering].should be_nil
      flash[:warning].should_not be_nil
    end

  end

  describe "on show" do

    before do
      @registration = mock("registration")
      @day_of_action = mock("day of action")
      @registration.stub!(:day_of_action).and_return(@day_of_action)
    end

    it "it should find registration and expose it and its day_of_action to view" do
      Registration.should_receive(:find).with("3").and_return(@registration)
      get 'show', :id => 3
      response.should be_success
      assigns[:registration].should equal(@registration)
      assigns[:day_of_action].should equal(@day_of_action)
    end
  end

  describe "on destroy" do

    before do
      @registration = mock("registration")
      @registration.stub!(:destroy)
      @email = "foo@bar.com"
      @registration.stub!(:email_address).and_return(@email)
      @day_of_action = mock("day of action")
      @registration.stub!(:day_of_action).and_return(@day_of_action)
      Registration.stub!(:find).and_return(@registration)
    end

    describe "if email adresses match" do


      it "should destroy the registration" do
        @registration.should_receive(:destroy)
        post 'destroy', {:id => 3, :registration_registered_email_address => @email}
      end

      it "should redirect to new form with message set" do
        Registration.should_receive(:find).with("3").and_return(@registration)
        post 'destroy', {:id => 3, :registration_registered_email_address => @email}
        response.should redirect_to(new_days_of_action_registration_path(@day_of_action))
        flash[:message].should_not be_nil
      end
    end

    describe "if email adresses do not match" do
      it "should not destroy the registration" do
        @registration.should_not_receive(:destroy)
        post 'destroy', {:id => 3, :registration_registered_email_address => "some other email"}
      end

      it "should redirect to show with message set" do
        post 'destroy', {:id => 3, :registration_registered_email_address => "some other email"}
        response.should redirect_to(:action => "show")
        flash[:warning].should_not be_nil
      end
    end

  end

end
