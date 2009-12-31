Feature: Volunteer registers for a time slot in a day of action
  In order to prevent everyone calling at once
  A volunteer
  wants to register for a particular timeslot
  
  
  Scenario: Slot is shown as taken after successful registration
    Given a Day of Action has been set up for "1975-07-30" in "Canberra"
    
    When I view the roster for the day of action
    And I register for the "09:15" timeslot
    
    Then I will be thanked and asked to look for an email
    And the "09:15" timeslot will now be shown as taken

   Scenario: Email address is not valid
    Given a Day of Action has been set up for "1975-07-30" in "Canberra"
   
    When I view the roster for the day of action
    And I register for the "09:15" timeslot with email address ""
    Then I will be reminded to enter an email address
    And the "09:15" timeslot will still be shown as free
    But the "09:15" timeslot will still be selected
    
  Scenario: User Doesn't provide anything
    Given a Day of Action has been set up for "1975-07-30" in "Canberra"
 
    When I view the roster for the day of action
    And I press "Register"
    Then I will be reminded to choose a time
    And I will be reminded to enter an email address
    
  Scenario: User Doesn't provide anything
    Given a Day of Action has been set up for "1975-07-30" in "Canberra"

    When I view the roster for the day of action
    And I fill in "What is your email address?" with "foo@bar.com"
    And I press "Register"
    Then I will be reminded to choose a time
    And the "What is your email address?" field should contain "foo@bar.com"
 
  
  Scenario: Someone else gets in first
Scenario: picks a taken time