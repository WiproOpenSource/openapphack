Feature: Mnemonics

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Shortcut for listing an uninstalled available Version
    Given I do not have a "panickervinod" candidate installed
    And a "panickervinod" list view is available for consumption
    When I enter "app l panickervinod"
    Then I see "Available Panickervinod Versions"

  Scenario: Alternate shortcut for listing uninstalled available Version
    Given I do not have a "panickervinod" candidate installed
    And a "panickervinod" list view is available for consumption
    When I enter "app ls panickervinod"
    Then I see "Available Panickervinod Versions"

  Scenario: Shortcut for asking help
    When I enter "app h"
    Then I see "Usage: app <command> <candidate> [version]"

  Scenario: Shortcut for displaying current Candidate Version in use
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    When I enter "app c panickervinod"
    Then I see "Using panickervinod version 0.0.1"

  Scenario: Shortcut for displaying current Candidate Versions
    Given the candidate "openapphack" version "master" is already installed and default
    And the candidate "panickervinod" version "master" is already installed and default
    When I enter "app c"
    Then I see "Using:"
    And I see "panickervinod: master"
    And I see "openapphack: master"

  Scenario: Shortcut for displaying outdated Candidate Version in use
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    And the default "panickervinod" candidate is "master"
    When I enter "app o panickervinod"
    Then I see "Outdated:"
    And I see "panickervinod (0.0.1 < master)"

  Scenario: Shortcut for displaying outdated Candidate Versions
    Given  the candidate "panickervinod" version "0.0.1" is already installed and default
    And the default "panickervinod" candidate is "master"
    And the candidate "openapphack" version "0.0.1" is already installed and default
    And the default "openapphack" candidate is "master"
    When I enter "app o"
    Then I see "Outdated:"
    And I see "panickervinod (0.0.1 < master)"
    And I see "openapphack (0.0.1 < master)"

  Scenario: Shortcut for installing a Candidate Version
    Given the candidate "panickervinod" version "master" is not installed
    And the candidate "panickervinod" version "master" is available for download
    When I enter "app i panickervinod master" and answer "Y"
    Then I see "Installing: panickervinod master"
    And the candidate "panickervinod" version "master" is installed

  Scenario: Shortcut for uninstalling a Candidate Version
    Given the candidate "openapphack" version "master" is already installed and default
    When I enter "app rm openapphack master"
    Then I see "Uninstalling openapphack master"
    And the candidate "openapphack" version "master" is not installed

  Scenario: Shortcut for showing the current Version of app
    When I enter "app v"
    Then I see "OpenAppHack CLI x.y.z"

  Scenario: Shortcut for using a candidate version that is installed
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "master" is a valid candidate version
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    And the candidate "panickervinod" version "0.0.1" is a valid candidate version
    When I enter "app u panickervinod 0.0.1"
    Then I see "Using panickervinod version 0.0.1 in this shell."
    Then the candidate "panickervinod" version "0.0.1" should be in use
    And the candidate "panickervinod" version "master" should be the default

  Scenario: Shortcut for defaulting a Candidate Version that is installed and not default
    Given the candidate "openapphack" version "master" is already installed but not default
    And the candidate "openapphack" version "master" is a valid candidate version
    When I enter "app d openapphack master"
    Then I see "Default openapphack version set to master"
    And the candidate "openapphack" version "master" should be the default

  Scenario: Shortcut for a Broadcast command issued
    Given no prior Broadcast was received
    And a new Broadcast "This is a LIVE Broadcast!" with id "12345" is available
    When I enter "app b"
    Then I see "This is a LIVE Broadcast!"
