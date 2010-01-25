class BusinessHoursScheduler

  def each_time_slot_in(date, timezone)
    midnight = midnight_in_timezone(date, timezone)

    start_time = midnight + 9.hours
    end_time = midnight + 17.hours
    time = start_time
    while time < end_time do
      yield time
      time = 5.minutes.since(time)
    end
  end

  private

  def midnight_in_timezone(date, timezone)
    # 1) find midnight on the date in UTC
    # 2) convert it to a time in the required timezone
    # 3) find previous midnight in that timezone
    date.to_time(:utc).in_time_zone(timezone).midnight
  end

end
