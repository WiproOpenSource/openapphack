Feature: Outdated Candidate

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Display outdated candidate version in use when it is outdated
    Given the candidate "panickervinod" version "master" is already installed and default
    And the default "panickervinod" candidate is "2.4.4"
    When I enter "app outdated panickervinod"
    Then I see "Outdated:"
    And I see "panickervinod (master < 2.4.4)"

  Scenario: Display outdated candidate version in use when it is not outdated
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    And the default "panickervinod" candidate is "0.0.1"
    When I enter "app outdated panickervinod"
    Then I see "panickervinod is up-to-date"

  Scenario: Display outdated candidate version when none is in use
    Given the candidate "panickervinod" does not exist
    When I enter "app outdated panickervinod"
    Then I see "Not using any version of panickervinod"

  Scenario: Display outdated candidate versions when none is specified and none is in use
    Given the candidate "panickervinod" does not exist
    When I enter "app outdated"
    Then I see "No candidates are in use"

  Scenario: Display outdated candidate versions when none is specified and one is in use
    Given the candidate "panickervinod" version "master" is already installed and default
    And the default "panickervinod" candidate is "2.4.4"
    When I enter "app outdated"
    Then I see "Outdated:"
    And I see "panickervinod (master < 2.4.4)"

  Scenario: Display outdated candidate versions when none is specified and multiple are in use
    Given  the candidate "panickervinod" version "master" is already installed and default
    And the default "panickervinod" candidate is "2.4.4"
    And the candidate "openapphack" version "master" is already installed and default
    And the default "openapphack" candidate is "2.4.1"
    When I enter "app outdated"
    Then I see "Outdated:"
    And I see "panickervinod (master < 2.4.4)"
    And I see "openapphack (master < 2.4.1)"

  Scenario: Display outdated candidate versions when none is specified and multiple are in use but they are not outdated
    Given  the candidate "panickervinod" version "master" is already installed and default
    And the default "panickervinod" candidate is "master"
    And the candidate "openapphack" version "master" is already installed and default
    And the default "openapphack" candidate is "master"
    When I enter "app outdated"
    Then I see "All candidates are up-to-date"
