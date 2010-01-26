Given /^a Day of Action has been set up for "([^\"]*)" in "([^\"]*)"$/ do |date, time_zone|
  @day_of_action = DayOfAction.create!(:scheduler => BusinessHoursScheduler.new, :date => Date.parse(date), :time_zone => time_zone)
end


Given /^a Day of Action has been set up for:$/ do |table|
  table.hashes.each do |hash|
    @day_of_action = DayOfAction.create!({"scheduler" => BusinessHoursScheduler.new, "time_zone" => "Canberra"}.merge(hash))
  end
end

When /^the administrator sends out reminders$/ do
  @day_of_action.send_reminders
end