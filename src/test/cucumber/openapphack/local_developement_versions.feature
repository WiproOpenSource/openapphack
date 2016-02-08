Feature: Local Development Versions

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Install a new local development version
    Given the candidate "openapphack" version "master" is not available
    And I have a local candidate "openapphack" version "master" at "/.vms/openapphack/master"
    When I enter "app install openapphack master /.vms/openapphack/master"
    Then I see "Linking openapphack master to /.vms/openapphack/master"
    And the candidate "openapphack" version "master" is linked to /.vms/openapphack/master"

  Scenario: Attempt installing a local development version that already exists
    Given the candidate "openapphack" version "master" is not available
    And the candidate "openapphack" version "master" is already linked to "/.vms/openapphack/master"
    When I enter "app install openapphack master /.vms/openapphack/master"
    Then I see "Stop! openapphack master is already installed."
    And the candidate "openapphack" version "master" is linked to "/.vms/openapphack/master"

  Scenario: Uninstall a local development version
    Given the candidate "openapphack" version "master" is already linked to "/.vms/openapphack/master"
    When I enter "app uninstall openapphack master"
    Then I see "Uninstalling openapphack master"
    And the candidate "openapphack" version "master" is not installed

  Scenario: Attempt uninstalling a local development version that is not installed
    Given the candidate "openapphack" version "master" is not installed
    When I enter "app uninstall openapphack master"
    Then I see "openapphack master is not installed."

  Scenario: Make the local development version the default for the candidate
    Given the candidate "openapphack" version "0.0.1" is already installed and default
    And the candidate "openapphack" version "master" is not available
    And the candidate "openapphack" version "master" is already linked to "/.vms/openapphack/master"
    When I enter "app default openapphack master"
    Then I see "Default openapphack version set to master"
    And the candidate "openapphack" version "master" should be the default

  Scenario: Use a local development version
    Given the candidate "openapphack" version "0.0.1" is already installed and default
    And the candidate "openapphack" version "master" is not available
    And the candidate "openapphack" version "master" is already linked to "/.vms/openapphack/master"
    When I enter "app use openapphack master"
    Then I see "Using openapphack version master in this shell"
    And the candidate "openapphack" version "master" should be in use
