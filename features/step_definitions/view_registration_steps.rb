When /^I view a registration that does not exist$/ do
 visit registrations_path -1
end

When /^I view my registration$/ do
  visit registrations_path @last_registration
end

Then /^I will be reminded that I have registered for "([^\"]*)" timeslot$/ do |time|
  response.should have_tag("#registered_time", time)
end
