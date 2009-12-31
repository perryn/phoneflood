class BusinessHoursScheduler

  def each_time_slot_in(date, timezone)
    # 1) find midnight on the date in UTC 
    # 2) convert it to a time in the required timezone 
    # 3) find previous midnight in that timezone
    midnight_in_timezone = date.to_time(:utc).in_time_zone(timezone).midnight
   
    start_time = midnight_in_timezone + 9.hours
    end_time = midnight_in_timezone + 17.hours
    time = start_time
    while time < end_time do
      yield time
      time = 5.minutes.since(time)
    end
  end

end
