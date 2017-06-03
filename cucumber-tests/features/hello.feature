# Author: Mallozup

# About the syntax of this file, read:
# https://github.com/cucumber/cucumber/wiki/Gherkin

Feature: Do some small tests
  Learn cucumber basic
      
  Scenario: Access and verify suse.com webpage
    Given I ping "www.suse.com"
    And I navigate to "https://www.suse.com/"
    Then I should see a "Products & Solutions" text
      
  Scenario: Click a link and take a screenshot on suse.com
    Given I ping "www.suse.com"
    And I navigate to "https://www.suse.com/"
    Then I should see a "Products & Solutions" text
    When I click "contact"
    Then I should not see a "Products & Solutions" text
    And I take a screenshot
