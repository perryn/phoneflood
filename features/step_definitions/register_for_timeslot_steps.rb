When /^I register for the "([^\"]*)" timeslot$/ do |time|
  When "I register for the \"#{time}\" timeslot with email address \"foo@bar.com\""
end

When /^I register for the "([^\"]*)" timeslot with email address "([^\"]*)"$/ do |time, email|
  choose time
  fill_in(:registration_email_address, :with => email)
  click_button "Register"
end

When /^someone else registers for the "([^\"]*)" time slot while I am looking$/ do |time|
  time_slot = @day_of_action.time_slots.select{|slot| slot.start_time.strftime("%I:%M") == "09:15"}[0]
  time_slot.registration = Registration.new(:email_address => "foo@bar.com")
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

Then /^I will be asked to pick a different time$/ do
  response.should contain("Please choose another time")
end

Then /^the "([^\"]*)" timeslot will still be selected$/ do |time|
  field_labeled(time).should be_checked
end
