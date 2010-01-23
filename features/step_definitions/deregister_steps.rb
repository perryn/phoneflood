When /^I de\-register with email address "([^\"]*)"$/ do |email|
  fill_in(:registration_registered_email_address, :with => email)
  click_button "Sorry, I can't make it"
end

Then /^I will be thanked and asked to try a different time$/ do
  response.should have_tag(".ok_message", "Thanks for letting us know. Why not register for a different time?")
end

Then /^I will be asked to try again$/ do
 response.should contain("Please try again")
end
