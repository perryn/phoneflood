When /^I register for the "([^\"]*)" timeslot$/ do |time|
  When "I register for the \"#{time}\" timeslot with email address \"foo@bar.com\""
end

When /^I register for the "([^\"]*)" timeslot with email address "([^\"]*)"$/ do |time, email|
  choose time
  fill_in(:registration_email_address, :with => email)
  click_button "Register"
end

Then /^I will be thanked and asked to look for an email$/ do
  response.should have_tag(".thanks_for_registering")
end

Then /^I will be reminded to enter an email address$/ do
  response.should contain("please tell us your email address")
end

Then /^I will be reminded to choose a time$/ do
  response.should contain("please choose a time")
end

Then /^the "([^\"]*)" timeslot will still be selected$/ do |time|
  field_labeled(time).should be_checked
end
