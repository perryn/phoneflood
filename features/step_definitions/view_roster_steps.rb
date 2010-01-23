Given /^a Day of Action has been set up for "([^\"]*)" in "([^\"]*)"$/ do |date, time_zone|
  @day_of_action = DayOfAction.create!(:scheduler => BusinessHoursScheduler.new, :date => Date.parse(date), :time_zone => time_zone)
end


Given /^a Day of Action has been set up for:$/ do |table|
  table.hashes.each do |hash|
    @day_of_action = DayOfAction.create!(hash.merge({:scheduler => BusinessHoursScheduler.new, :time_zone => "Canberra"}))
  end
end

Given /^the "([^\"]*)" slot has already been taken$/ do |time|
  When "I view the roster for the day of action"
  When "I register for the \"#{time}\" timeslot"
end

When /^I view the roster for the day of action$/ do
  visit new_days_of_action_registration_path @day_of_action
end

When /^I view the roster for the day of action that does not exist$/ do
  visit new_days_of_action_registration_path -1
end

Then /^I will be shown the roster for the day of action$/ do
  current_url.should =~  /#{new_days_of_action_registration_path @day_of_action}/
end

Then /^I will see a 404$/ do
  response.code.should == "404"
end


Then /^I will see a section for each hour between 9 am and 5 pm$/ do
  expected_hours = ["09 AM", "10 AM", "11 AM", "12 PM", "01 PM", "02 PM", "03 PM", "04 PM"]
  actual_hours = element_at("#roster").to_table.collect { |row| row.first}
  actual_hours.should eql expected_hours
end

Then /^each section will be divided into 5 minute slots$/ do

  expected_times = ["09:00", "09:05", "09:10", "09:15", "09:20", "09:25", "09:30", "09:35", "09:40", "09:45", "09:50", "09:55",
    "10:00", "10:05", "10:10", "10:15", "10:20", "10:25", "10:30", "10:35", "10:40", "10:45", "10:50", "10:55",
    "11:00", "11:05", "11:10", "11:15", "11:20", "11:25", "11:30", "11:35", "11:40", "11:45", "11:50", "11:55",
    "12:00", "12:05", "12:10", "12:15", "12:20", "12:25", "12:30", "12:35", "12:40", "12:45", "12:50", "12:55",
    "01:00", "01:05", "01:10", "01:15", "01:20", "01:25", "01:30", "01:35", "01:40", "01:45", "01:50", "01:55",
    "02:00", "02:05", "02:10", "02:15", "02:20", "02:25", "02:30", "02:35", "02:40", "02:45", "02:50", "02:55",
    "03:00", "03:05", "03:10", "03:15", "03:20", "03:25", "03:30", "03:35", "03:40", "03:45", "03:50", "03:55",
  "04:00", "04:05", "04:10", "04:15", "04:20", "04:25", "04:30", "04:35", "04:40", "04:45", "04:50", "04:55"]

  actual_times = []
  response.should have_tag("#roster .hour td label") do |slots|
    actual_times = slots.map{|tag| tag.to_s.match(/\d\d:\d\d/)[0]}
  end

  actual_times.should eql expected_times
end

Then /^each slot will be free$/ do
  number_of_free_slots = 0
  number_of_slots = 0

  response.should have_tag("#roster .hour td.free label") do |free_slots|
    number_of_free_slots = free_slots.size
  end

  response.should have_tag("#roster .hour td label") do |all_slots|
    number_of_slots = all_slots.size
  end

  number_of_free_slots.should eql number_of_slots
end

Then /^the "([^\"]*)" timeslot will now be shown as taken$/ do |time|
  Then "the \"#{time}\" timeslot will be shown as taken"
end

Then /^the "([^\"]*)" timeslot will be shown as taken$/ do |time|
  response.should have_tag(".taken") do
    with_tag "label", time
  end
  #there should not be any radio button for that time
  lambda{field_labeled(time)}.should raise_error(Webrat::NotFoundError)
end

Then /^the "([^\"]*)" timeslot will still be shown as free$/ do |time|
  Then "the \"#{time}\" timeslot will be shown as free"
end

Then /^the "([^\"]*)" timeslot will be shown as free$/ do |time|
  response.should have_tag(".free") do
    with_tag "label", time
  end
  #there should be a radio button for that time
  lambda{field_labeled(time)}.should_not raise_error(Webrat::NotFoundError)
end

Then /^I will be reminded that the times are in "([^\"]*)"$/ do |time_string|
  response.should have_tag(".time_zone_reminder", time_string)
end

Then /^I will see a blurb that explains that on "([^\"]*)" we will call "([^\"]*)" on "([^\"]*)" about "([^\"]*)"$/ do |date, recipient, phone, subject|
  response.should have_tag("#blurb") do
    with_tag("#date", date)
    with_tag("#recipient", recipient)
    with_tag("#phone", phone)
    with_tag("#subject", subject)
  end
end
