Feature: Version

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Show the current version of app
    When I enter "app version"
    Then I see "OpenAppHack CLI x.y.z"
