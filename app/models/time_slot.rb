class TimeSlot < ActiveRecord::Base
  has_one :registration

  def status
    registration ? "taken" : "free"
  end
  
  def available?
    status == "free"
  end

end
