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
      original_tz = Time.zone
      Time.zone = day_of_action.time_zone
      result = start_time.strftime(format)
      Time.zone = original_tz
      result
    end

end
