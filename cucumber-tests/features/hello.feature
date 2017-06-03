# Author: Mallozup

# About the syntax of this file, read:
# https://github.com/cucumber/cucumber/wiki/Gherkin

Feature: Do some small tests
  Learn cucumber basic
      
  Scenario: Access and verify suse.com webpage
    Given I ping "www.suse.com"
    And I navigate to "https://www.suse.com/"
    Then I should see a "Products & Solutions" text
    Then I should see a "Strategic Partners" text
    Then I should see a "SUSE, All Rights Reserved" text

  Scenario: Click a link and take a screenshot on suse.com
    Given I ping "www.suse.com"
    And I navigate to "https://www.suse.com/"
    Then I should see a "Products & Solutions" text
    When I click "Jobs"
    Then I should not see a "Products & Solutions" text
    Then I should see a "FAIL_FOR_FUN" text
