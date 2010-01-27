class TimeSlot < ActiveRecord::Base
  has_one :registration
  belongs_to :day_of_action
  alias_method :real_registration=, :registration=

  def status
    registration ? "taken" : "free"
  end

  def available?
    registration.nil?
  end

  def registration=(registration)
    raise TooSlowError unless available?
    self.real_registration = registration
  end

  def strftime(format)
    start_time.in_time_zone(day_of_action.time_zone).strftime(format)
  end

end
