Feature: Volunteer views current roster for a day of action
  In order to see what timeslots are not yet filled
  A volunteer
  wants to see the current state of the roster for a day of action
  
  @allow-rescue
  Scenario: Roster for non-existant day of action will 404
   When I view the roster for the day of action that does not exist
   Then I will see a 404
  
  Scenario: Initially the roster will display an empty space for each timeslot
    Given a Day of Action has been set up for "1975-07-30" in "Perth"
    When I view the roster for the day of action
    Then I will see a section for each hour between 9 am and 5 pm
    And each section will be divided into 5 minute slots
    And each slot will be free
    And I will be reminded that the times are in "Perth Time"
    
  Scenario: Slots that are already taken will be shown as taken
  

