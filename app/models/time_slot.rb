class TimeSlot < ActiveRecord::Base
  has_one :registration
  alias_method :real_registration=, :registration=

  def status
    registration ? "taken" : "free"
  end

  def available?
    registration.nil?
  end

  def registration=(registration)
    if !available?
      raise TooSlowError
    else
      self.real_registration = registration
    end
  end

end
