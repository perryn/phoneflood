Feature: Volunteer changes their registration
  In order to allow others to volunteer for a slot that they can no longer do
  A volunteer
  wants to change their registration
  
  @allow-rescue
  Scenario: page for non-existant registration will 404
   When I view a registration that does not exist
   Then I will see a 404
  
  Scenario: Volunteer will be reminded of details of registration 
   Given a Day of Action has been set up for:
      | date       |      recipient       | phone             | subject                |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    |
      
    And I have registered for the "09:15" timeslot
    
    When I view my registration
    Then I will see a blurb that explains that on "Tuesday 5th January 2010" we will call "Kevin Rudd's Office" on "(02) 6277 7700" about "The Internet Filter"
    And I will be reminded that I have registered for "09:15 AM" timeslot
    
  Scenario: Volunteer can de-register for a timeslot
    Given a Day of Action has been set up for:
      | date       |      recipient       | phone             | subject                |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    |
     
    And I have registered for the "09:15" timeslot with email address "scott@tiger.com" 
    When I view my registration
    And I de-register with email address "scott@tiger.com"
    Then I will be thanked 
    
    When I view the roster for the day of action
    Then the "09:15" timeslot will be shown as free

  Scenario: Volunteer tries to de-register with wrong email address    
    
  Scenario: Volunteer can re-register for a different timeslot
  
  Scenario: Reminded of time zone