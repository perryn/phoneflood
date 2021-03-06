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
      | date       |      recipient       | phone             | subject                | time_zone |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    | Canberra  |
      
    And I have registered for the "09:15" timeslot
    
    When I view my registration
    Then I will see a blurb that explains that on "Tuesday 5th January 2010" we will call "Kevin Rudd's Office" on "(02) 6277 7700" about "The Internet Filter"
    And I will be reminded that I have registered for "09:15 AM" timeslot in "Canberra" time
    
  Scenario: Volunteer can de-register for a timeslot and re-register for a different timeslot
    Given a Day of Action has been set up for:
      | date       |      recipient       | phone             | subject                |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    |
     
    And I have registered for the "09:15" timeslot with email address "scott@tiger.com" 
    When I view my registration
    And I de-register with email address "scott@tiger.com"
    Then I will be thanked and asked to try a different time
    
    And I will be shown the roster for the day of action
    And the "09:15" timeslot will be shown as free
    
    When I register for the "09:15" timeslot with email address "scott@tiger.com"
    Then I will be thanked and asked to look for an email
    And the "09:15" timeslot will now be shown as taken

  Scenario: Volunteer tries to de-register with wrong email address    
    Given a Day of Action has been set up for:
      | date       |      recipient       | phone             | subject                |
      | 2010-01-05 |  Kevin Rudd's Office | (02) 6277 7700    | The Internet Filter    |
   
      And I have registered for the "09:15" timeslot with email address "scott@tiger.com" 
      When I view my registration
      Then the "What email address did you register with?" field should not contain "scott@tiger.com" 
      
      When I de-register with email address "someone@else.com"
      Then I will be asked to try again
  
