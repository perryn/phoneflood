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
      time_slot.registration = registration
      flash[:thanks_for_registering] = "true"
    end
    flash[:registration] = registration
    redirect_to :action => :new
  end
end
