Feature: System will confirm registrations via email

  For future reference
  A volunteer
  wants to receive an email confirming their registration
  
  
  Scenario: Volunteer will be sent email with details of their registration
   
   Given a Day of Action has been set up for:
      | date       |      recipient       | phone             | subject                |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    |
    When I view the roster for the day of action
    
    When I view the roster for the day of action
    And I register for the "09:15" timeslot with email address "foo@bar.com"
    
    Then I will receive a confirmation email at "foo@bar.com"
    And the email will confirm that I have registered to call "Kevin Rudd's Office" on "(02) 6277 7700" about "The Internet Filter"
    And the email will confirm that I have registered to call at "09:15 AM" on "Tuesday 5th January 2010" 