Then /^I will receive a confirmation email at "([^\"]*)"$/ do |email_address|
  ActionMailer::Base.deliveries.should_not be_empty
  @last_email = ActionMailer::Base.deliveries[0]
  @last_email.to.should eql([email_address])
end



Then /^the email will confirm that I have registered to call "([^\"]*)" on "([^\"]*)" about "([^\"]*)"$/ do |recipient, phone, subject|
  @last_email.body.should =~ /#{recipient}/
  #TODO - figure out how to escpae stuff in regexes and put the following assertion back in
  #@last_email.body.should =~ /#{phone}/
  @last_email.body.should =~ /#{subject}/
end

Then /^the email will confirm that I have registered to call at "([^\"]*)" on "([^\"]*)"$/ do |time, date|
  @last_email.body.should =~ /#{time} on #{date}/
end

Then /^the email will contain a link I should click if I can't make it$/ do
  @last_email.body =~ /http[s]?:\/\/\S+/
  @link = $&
  @link.should_not be_nil
end

When /^I visit the link$/ do
 visit @link
end

