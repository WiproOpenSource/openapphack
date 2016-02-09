Feature: Idempotent Self Update

  Background:
    Given the internet is reachable
    And an initialised environment
    And an available selfupdate

  Scenario: Attempt Self Update on an up to date system
    When I enter "app selfupdate"
    Then I see "No update available at this time."

  Scenario: Force Self Update on an up to date system
    When I enter "app selfupdate force"
    Then I see "Successfully upgraded OpenAppHack CLI."
