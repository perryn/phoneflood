class RegistrationsController < ApplicationController

  def new
    @day_of_action = DayOfAction.find(params[:days_of_action_id])
    @registration = flash[:registration]
    Time.zone = @day_of_action.time_zone
  end

  def create
    registration = Registration.new(params[:registration])
    if registration.valid?
      time_slot = TimeSlot.find(params[:registration][:time_slot_id])
      begin
        time_slot.registration = registration
        flash[:message] = "Thanks for helping out!  We have sent you a confirmation email with further instructions."
      rescue TooSlowError
        flash[:warning] = "Too Slow! Someone else just registered for that time. Please choose another time."
      end
    end
    flash[:registration] = registration
    redirect_to :action => :new
  end

  def show
    @registration = Registration.find(params[:id])
    @day_of_action = @registration.day_of_action
  end

  def destroy
    registration = Registration.find(params[:id])
    submitted_email = params[:registration_registered_email_address]
    if (submitted_email == registration.email_address)
      day_of_action = registration.day_of_action
      registration.destroy
      flash[:message] = "Thanks for letting us know. Why not register for a different time?"
      redirect_to new_days_of_action_registration_path(day_of_action)
    else
      flash[:warning] = "That does not seem to be the email address you registered with. Please try again."
      redirect_to :action => :show
    end
  end

end
