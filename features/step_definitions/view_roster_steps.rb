Given /^a Day of Action has been set up for "([^\"]*)" in "([^\"]*)"$/ do |date, time_zone|
  @day_of_action = DayOfAction.create!(:scheduler => BusinessHoursScheduler.new, :date => Date.parse(date), :time_zone => time_zone)
end

When /^I view the roster for the day of action$/ do
  visit new_days_of_action_registration_path @day_of_action
end

When /^I view the roster for the day of action that does not exist$/ do
  visit new_days_of_action_registration_path -1
end

Then /^I will see a 404$/ do
  response.code.should == "404"
end


Then /^I will see a section for each hour between 9 am and 5 pm$/ do
  expected_hours = ["09 AM", "10 AM", "11 AM", "12 PM", "01 PM", "02 PM", "03 PM", "04 PM"]
  actual_hours = element_at(".roster").to_table.collect { |row| row.first}
  actual_hours.should eql expected_hours
end

Then /^each section will be divided into 5 minute slots$/ do
  # just check the first row is probably enough at this level
  expected_times = ["09:00", "09:05", "09:10", "09:15","09:20", "09:25","09:30", "09:35","09:40", "09:45","09:50", "09:55"]
  html_table_row = element_at(".roster").to_table.first
  #remove header
  html_table_row.delete_at(0)
  actual_times = html_table_row.map{|text| text.match(/\d\d:\d\d/)[0]}
  actual_times.should eql expected_times
end

Then /^each slot will be free$/ do
  number_of_free_slots = 0
  number_of_slots = 0

  response.should have_tag(".roster .hour td.free") do |free_slots|
    number_of_free_slots = free_slots.size
  end

  response.should have_tag(".roster .hour td") do |all_slots|
    number_of_slots = all_slots.size
  end

  number_of_free_slots.should eql number_of_slots
end

Then /^the "([^\"]*)" timeslot will now be shown as taken$/ do |time|
  response.should have_tag(".taken") do
    with_tag "label", time
  end
end

Then /^the "([^\"]*)" timeslot will still be shown as free$/ do |time|
  response.should have_tag(".free") do
    with_tag "label", time
  end
end

Then /^I will be reminded that the times are in "([^\"]*)"$/ do |time_string|
  response.should have_tag(".time_zone_reminder", time_string)
end
