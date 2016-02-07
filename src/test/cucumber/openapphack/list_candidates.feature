@manual
Feature: List Candidates

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: List an uninstalled available Version
    Given I do not have a "panickervinod" candidate installed
    When I enter "app list panickervinod"
    Then I see "Available OpenAppHack  Versions"
    And I see "     master"

  Scenario: List an installed available Version not in use
    Given the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app list panickervinod"
    Then I see "Available OpenAppHack Versions"
    And I see "   * master"

  Scenario: List an installed available Version in use
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app list panickervinod"
    Then I see "Available OpenAppHack Versions"
    And I see " > * master"

  Scenario: List an installed local version not in use
    Given I have a local candidate "panickervinod" version "0.0.1" at "/tmp/openapphack-core"
    And the candidate "openapphack" version "master" is already linked to "/tmp/openapphack-core"
    When I enter "app list openapphack"
    Then I see "Available openapphack Versions"
    And I see "   + master"

  Scenario: List an installed local Version in use
    Given I have a local candidate "openapphack" version "master" at "/tmp/openapphack-core"
    And the candidate "openapphack" version "master" is already linked to "/tmp/openapphack-core"
    And the candidate "openapphack" version "master" is the default
    When I enter "app list openapphack"
    Then I see "Available openapphack Versions"
    And I see " > + master"
