When /^I de\-register with email address "([^\"]*)"$/ do |email|
  fill_in(:registration_email_address, :with => email)
  click_button "Undo Registration"
end
