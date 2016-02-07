Feature: Current Candidate

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Display current candidate version in use
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app current panickervinod"
    Then I see "Using panickervinod version master"

  Scenario: Display current candidate version when none is in use
    Given the candidate "panickervinod" version "master" is already installed but not default
    When I enter "app current panickervinod"
    Then I see "Not using any version of panickervinod"

  Scenario: Display current candidate versions when none is specified and none is in use
    Given the candidate "panickervinod" version "master" is already installed but not default
    When I enter "app current"
    Then I see "No candidates are in use"

  Scenario: Display current candidate versions when none is specified and one is in use
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app current"
    Then I see "Using:"
    And I see "panickervinod: master"

  Scenario: Display current candidate versions when none is specified and multiple are in use
    Given the candidate "openapphack" version "master" is already installed and default
    And the candidate "panickervinod" version "master" is already installed and default
    When I enter "app current"
    Then I see "Using:"
    And I see "panickervinod: master"
    And I see "openapphack: master"
